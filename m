Date: Sun, 18 Jan 2004 17:30:57 +0000
Message-ID: <3FCAE98A0003E0EF@hawk.dcu.ie>
From: "Gavin O' Gorman" <gavin.ogorman2@mail.dcu.ie>
Subject: ipsec network labeling/network management
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, 

My apologies if this mail is OT. I'm interested in a possible project concerning
SELinux. Specifically, implementing a policy management tool/daemon for
a network of machines running SELinux. The daemon would set the policies
to be used on the LAN. For example, policies concerning network traffic
could be issued to client machines. Denying traffic from certain ips/ports
to other machines and so forth.
It could possibly be plugged into a IDS of some shape or form and dynamicly
update the policies upon detection of worms/incidents.. Possibly. It would
allow for easy management of client machine policies, editing and updating.

>From a quick search through the archives, I see that a few people are working
on the ipsec/network labelling. I'm not certain if this was for 2.4 or 2.6
however ? Obviously, for the policy daemon to be effective with regards
setting policies on network traffic, this labelling would be required. If
nothing substantial has been done on this so far, I would be interested
in doing it, from the pov of laying the ground work for the policy daemon.

This project would be undertaken as a postgraduate practicum for around
2.5-3 months. I'd really appreciate peoples opinions on the idea as I have
only read through the SELinux documentation, and not examined any source
code as yet. Would the project be of any use ? Are there people out there
working on the same thing ?

Thanks very much, and again, apologies if this if off topic.

Gavin O' Gorman
MSc. Student 
Security & Forensic Computing, DCU, Ireland.
http://www.computing.dcu.ie




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
