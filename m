Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09801
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 16:13:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA23981
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 20:12:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA23977
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 20:12:39 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Linux Kongress tutorial
Date: Mon, 9 Sep 2002 22:13:44 +0200
Cc: linux-security-module@wirex.com
MIME-Version: 1.0
Message-Id: <200209092213.44558.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last week was Linux Kongress.

I started out with a 6 hour hands-on tutorial on SE Linux.  This didn't go as 
well as planned for a number of reasons.

One problem was that on the day before when starting to prepare I didn't power 
on all the machines, so on the day of the tutorial when I turned them all on 
the circuit-breaker tripped. :(  So we had lots of power outages with an end 
result of having no power and not having the image installed to the hard 
drives at the appointed start time.

Fortunately my network-install setup was pretty smooth and I had all 16 
machines up and running within 30 minutes of power being restored.

Unfortunately in my haste I had omitted some packages of software from the 
hard drives of the machines, so I put them on the FTP server of my laptop.  
Some confusion was caused by this and by the fact that I had included full 
file names (including version numbers) of the packages (and I had developed 
new versions between the publication date and the day of the tutorial).

Another problem was that the notes weren't as clear as they could have been (I 
have not written such a document before).  The biggest mistake I made was 
lack of repitition.  If something was mentioned in the previous section then 
I would not mention it again, I now believe that for a tutorial every section 
should start with "After doing foo which we learned in the previous section 
we will continue to do bar" or something similar.  EVERY student failed to 
edit the default_context after creating a new role, I had presumed that they 
would have recalled it from the section on adding a new user.  Whenever the 
majority of students fail to learn it's because the teacher has made a 
mistake, this is something I'll have to be more careful about in future.

The next issue was that I had planned for students to give accounts to other 
groups and to be able to monitor and control them while they are logged in.  
However no two groups were at that stage at the same time and everyone 
skipped it.  For future tutorials I plan to use NBD or some similar 
technology to store the data on the network.  Then at a snack break they can 
change machines such that groups at a similar skill level can cluster which 
will allow them to perform such tasks.

However the tutorial went quite well apart from these problems.  I was very 
surprised by the rate at which they learned, as some time was removed by the 
lack of power which corresponded to the section they skipped, so at the 
appointed end time everyone had finished the work.

I was actually surprised by how well the audience learned some of the 
concepts, I hadn't expected that everyone would complete the work in the time 
alotted.  I was glad to have such an intelligent group of people to teach!


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
