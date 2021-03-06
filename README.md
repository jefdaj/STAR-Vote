STAR-Vote
===

This fork of the *Secure, Transparent, Auditable and Reliable* voting system
focuses on reproducible builds, working demos, and blockchain integration. See
the [upstream README][1] for a better academic treatment: formal methods,
history of the code, etc.

*STAR-Vote* is a pragmatic system that tries to meet all the current
requirements for a real in-person election. The philosophy here is "move slowly
and don't break anything"; rather than start with a naive internet voting
scheme open to all manner of systemic attack vectors, we start with a
relatively traditional offline polling place and add cryptographic assurances.
The result looks similar to the current system from a user perspective, but is
more trustworthy.


### Voter Flow Overview

From the voter's perspective, there are several steps in the *STAR-Vote*
process; these result in a voter flow very similar to that typically found in
traditional polling places. Note that this is a high-level overview; many
details of the process are not described here.

1. *Sign-in*. The voter signs in with a poll worker (either electronically or
	 using traditional physical means). A sticker with the voter's name,
	 precinct, and ballot style is generated, placed in a poll book and signed by
	 the voter.
	 
2. *Ballot code generation*. The voter's sticker is scanned, and a ballot code
	 is generated. This code, which identifies the voter's ballot style but is
	 otherwise not linked to the voter's identity in any way, is given to the
	 voter. 
	 
3. *Voting*. The voter approaches a voting terminal, enters his ballot code,
	 and votes (as on any other DRE system).
	 
4. *Printing*. The voting terminal prints two items: a paper ballot including
	 both a human-readable summary and a computer-readable representation of the
	 voter's selections, and a take-home receipt that the voter can later use to
	 ensure his vote was counted.
	 
5. *Review*. The voter, if he chooses, reads the human-readable summary  or
	 (for accessibility) uses a ballot reading station to verify that his vote
	 was recorded as intended.
	 
6. *Cast or Audit/Spoil*. The voter either casts his ballot, by depositing it
	 at the vote submission station, or audits/spoils it, by giving it to a poll
	 worker who scans it into the controller. If the voter audits/spoils his
	 ballot, he can return to the *Voting* step and generate another.
	 
7. *Post-Election Review*. Once the election is over, the voter can check that
	 each ballot was appropriately counted and/or spoiled by using the
	 corresponding receipt from the *Printing* step.


### Current code

*STAR-Vote* is currently comprised of multiple components (Haskell binaries)
meant to run on physically separate machines:

- a *polling place controller* that manages the *STAR-Vote* protocol at a given
	polling place
	
- a *check-in station* used by voters to check in to a polling place

- a *ballot claim station* used by voters to obtain a ballot code after
	checking in
	
- a *voting terminal* at which voters mark their ballots electronically and
	receive filled paper ballots
	
- a *ballot reading station* that can scan a filled paper ballot and read it to
	the voter (for accessibility purposes)
	
- a *vote submission station* at which voters can cast their completed ballots. 

- *back-end applications* that handle the generation of encryption keys,
	maintenance of a voter status database, maintenance of a public authenticated
	write-only bulletin board, and tallying of cast ballots after an election.


### Development roadmap

The overall goal is to use [ATALA PRISM][3] for the election management and
voter registration process, and broadcast all public messages on
[the Cardano blockchain][2].

More specifically:

- [ ] Update the old code and get everything running on current Haskell and Nix
			infrastructure

- [ ] Explain the design to lay people with videos, demos, and blog posts

- [ ] Swap out the "public, append-only bulletin board" module for the public
			blockchain
			
- [ ] Write a reference implementation of the vote tallying and auditing code
			using a Cardano wallet
			
- [ ] Swap out the back-end management applications and voter check-in station
			for something built with PRISM
			
- [ ] Release it for testing by the public, and promote use in local elections

Once any bugs are worked out and it has been used successfully in real elections,
the next step will be to relax the in-person voting requirements and move toward
the more convenient system on your smartphone that everyone is really envisioning.
We can't rush that part without potentially breaking things.


[1]: https://github.com/FreeAndFair/STAR-Vote
[2]: https://explorer.cardano.org/en
[3]: https://www.youtube.com/watch?v=wemcgPA3IPQ
