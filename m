Date: Wed, 12 Dec 2001 12:50:16 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Dale Amon <amon@vnl.com>
cc: Secure Linux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: Undefined refs in compile attempt
In-Reply-To: <20011212014335.GA16538@vnl.com>
Message-ID: <Pine.LNX.4.31.0112121246490.8568-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 12 Dec 2001, Dale Amon wrote:

> At which point a make install fails:
>
> policydb.o: In function `user_destroy':
> /usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:357:
> undefined reference to `mls_user_destroy'

Check that you've set MLS=y in module/checkpolicy/Makefile, as mentioned
in the README.MLS file.


- James
-- 
James Morris
<jmorris@intercode.com.au>






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
