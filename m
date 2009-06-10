Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5ADwXOx008273
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 09:58:34 -0400
Received: from e2.ny.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5ADwMK8019643
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 13:58:22 GMT
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5ADs3HW004155
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 09:54:03 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5ADwUUU1224862
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 09:58:31 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5ADwPap015332
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 07:58:27 -0600
Date: Wed, 10 Jun 2009 08:58:33 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        Oren Laadan <orenl@cs.columbia.edu>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morgan <morgan@kernel.org>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 10/10] cr: lsm: restore file->f_security
Message-ID: <20090610135833.GA14218@us.ibm.com>
References: <20090610014412.GA5628@us.ibm.com> <20090610014704.GI5658@us.ibm.com> <4A2F2B08.40701@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A2F2B08.40701@schaufler-ca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Casey Schaufler (casey@schaufler-ca.com):
> > @@ -1630,7 +1654,6 @@ static int smack_msg_msg_restore_security(struct msg_msg *msg,
> >  		msg->security = str;
> >  	}
> >  	return 0;
> > -	return 0;
> >   
> 
> Looks like you caught that. Thank you

Huh.  No, I didn't :)  I'm guessing that both the original problem
and this accidental fix came about through my inexperience with
resolving conflicts in git-rebase...

Thanks for taking a look, I will address all of your comments in
the next posting.

For the next version I may split up the smack, selinux, and
tomoyo hooks into separate patches from the core LSM patch
(and nix the rather silly split of the security_file_restore
hook) for easier review...

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
