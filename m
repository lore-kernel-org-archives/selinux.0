Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6MJtEHa021971
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 15:55:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6MJs3FB001104
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 19:54:04 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6MJrrGD001018
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 19:54:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Rakesh Tripathi" <rtripathi@cougaarsoftware.com>, <selinux@tycho.nsa.gov>
Subject: Re: Few questions related to Selinux on Redhat 8.0
Date: Tue, 22 Jul 2003 15:54:44 -0400
References: <01d101c34fd7$12532e30$f40111ac@rtripathixp>
In-Reply-To: <01d101c34fd7$12532e30$f40111ac@rtripathixp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307221554.44650.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Jul 2003 18:26, Rakesh Tripathi wrote:
> 1.) How do I add new user to the system ?
> I tried using suseradd utility and I can see my user being added to the
> /etc/passwd file but when I try to login directly on the machine or through
> ssh it says incorrect password . Is there any thing more I need to do ?

Did you use "adminpasswd" to change the user's password after creating the 
user?

> 2.) I want only certain users to be able to run a particular application .
> For example I want user Joe to be able to run java. Can any one tell me how
> can I go about doing it or can some one point me to some documentation.

Do you just want an option as to whether the program is to be run or not?  Or 
do you also want to have it run in a different security context?

If the former then edit the policy to add a new file_type for the file and 
have policy to allow only appropriate user domains to read/execute it.

Then edit an appropriate file_contexts file (maybe types.fc) to add an entry 
for it.

Load the policy and relabel the file and it should work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
