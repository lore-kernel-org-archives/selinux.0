Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA23777
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 06:28:53 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA13365
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 11:25:58 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
	by jazzswing.ncsc.mil  with SMTP id LAA13361
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 11:25:57 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id LAA09506
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 11:34:33 GMT
Date: Tue, 28 Jan 2003 11:34:33 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: Some questions ...
Message-ID: <Pine.LNX.4.10.10301281113250.1316-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

First many thanks to the list for helping me get going - particularly
Russell, Stephen and Evan.  Having now a working SE Linux setup, although
not completely cofigured as yet, a number of questions arise:

1) When booting up, I still get a large number of avc denied messages. Do
(some of) these always come up or is it in principle possible to boot up
with no such messages?  I am obviously in permissive mode at the moment!:)

2) One cronned job really took over the machine - I think it was tripwire
(don't know why I had it installed at all) - where after a short period
(generally when I wasn't looking) the load meter went solid and absolutely
nothing could be done.  I tracked it down to a job initiated by cron from
cron.daily but it wasn't the usual 4am job so I deleted those that I
didn't want from the system and it has been OK since then.  Is it possible
that either an old job from the RH7.3-8 upgrade can have been interfering?  
I had to cold-boot the machine each time - jumping out of X could be done
early on in the take-over but after a little while even that was
impossible and doing anything from the console was also impossible.  I
tried to track down with 2 tops (one on load, one of latest process) but
nothing showed up at all.

3) If I boot into another kernel then back into selinux, do I have to run
make relabel each time?  It takes ages on my box - I would go into
overdose if I made coffee all the time.

4) Are there any implications for hyperthreading in selinux - ie on a Xeon
box should one disable hyperthreading?  I notice that on openMosix it is
currently advised (a kernel problem) although 2.6 should see it in OK.

5) I know it is not a good idea to start X from root (head hung in shame
but I am the only user at the moment and it is not connected to anything
sensitive) but an appropriate message saying it was not allowed would be
better than hanging the machine I think...  Is this in the new version?

6) When is the current CVS tree scheduled for release as a stable version?

Probably some more thoughts will hit me immediately after I hit the send
button but these will do for now...

TIA

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
