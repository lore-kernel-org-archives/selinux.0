Date: Fri, 28 Sep 2001 14:52:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux@tycho.nsa.gov
Subject: Re: install parameters
In-Reply-To: <20010928180802.58DC4369FB6@lyta.coker.com.au>
Message-ID: <Pine.SOL.3.95.1010928145107.624S-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 28 Sep 2001, Russell Coker wrote:

> Is there any reason why selinux/module/Makefile runs "install" without using 
> the "-m" parameter to specify the permissions?
> 
> I think that installing /usr/local/selinux/flask/* mode 755 is a bad idea, 
> executing them could lead to unexpected results (yes I know that people 
> should be smart enough to not execute them, but it's easy for us to get the 
> permissions right).

Yes, we can certainly add an explicit mode for the install commands run by
the selinux Makefiles.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
