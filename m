Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6MKFBHa022192
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 16:15:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6MKFADW016712
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 20:15:10 GMT
Received: from mvmail1.mv.cougaarsoftware.com (h-68-165-169-235.SNVACAID.covad.net [68.165.169.235])
        by jazzband.ncsc.mil  with ESMTP id h6MKF9eN016709 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 20:15:09 GMT
Message-ID: <029e01c3508d$f298d920$f40111ac@rtripathixp>
Reply-To: "Rakesh Tripathi" <rtripathi@cougaarsoftware.com>
From: "Rakesh Tripathi" <rtripathi@cougaarsoftware.com>
To: <selinux@tycho.nsa.gov>
References: <01d101c34fd7$12532e30$f40111ac@rtripathixp> <200307221554.44650.russell@coker.com.au>
Subject: Re: Few questions related to Selinux on Redhat 8.0
Date: Tue, 22 Jul 2003 13:15:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell ,
thanks for the response .
I have not changed the user passwd and i reloaded the policy after i added
the user.

Thanks
rakesh

----- Original Message -----
From: "Russell Coker" <russell@coker.com.au>
To: "Rakesh Tripathi" <rtripathi@cougaarsoftware.com>;
<selinux@tycho.nsa.gov>
Sent: Tuesday, July 22, 2003 12:54 PM
Subject: Re: Few questions related to Selinux on Redhat 8.0


> On Mon, 21 Jul 2003 18:26, Rakesh Tripathi wrote:
> > 1.) How do I add new user to the system ?
> > I tried using suseradd utility and I can see my user being added to the
> > /etc/passwd file but when I try to login directly on the machine or
through
> > ssh it says incorrect password . Is there any thing more I need to do ?
>
> Did you use "adminpasswd" to change the user's password after creating the
> user?
>
> > 2.) I want only certain users to be able to run a particular application
.
> > For example I want user Joe to be able to run java. Can any one tell me
how
> > can I go about doing it or can some one point me to some documentation.
>
> Do you just want an option as to whether the program is to be run or not?
Or
> do you also want to have it run in a different security context?
>
> If the former then edit the policy to add a new file_type for the file and
> have policy to allow only appropriate user domains to read/execute it.
>
> Then edit an appropriate file_contexts file (maybe types.fc) to add an
entry
> for it.
>
> Load the policy and relabel the file and it should work.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
