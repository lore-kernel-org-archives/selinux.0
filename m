From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>, lky <lky77@sjtu.edu.cn>
Subject: Re: can't start X window in enforce mode
Date: Mon, 13 Oct 2003 17:52:11 +1000
Cc: SELINUX <SELinux@tycho.nsa.gov>
References: <000901c390ef$d8b3c770$5d38a8c0@lky> <3F89E077.9030802@cisco.com>
In-Reply-To: <3F89E077.9030802@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310131752.11106.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Oct 2003 09:15, Michael Reilly wrote:
> I had both problems.  I added the dontaudit memory devices
> as mentioned in the file macros/program/xserver_macros.te.
>
> I have the second problem and have not yet solved it.  Nothing is logged
> and I cannot figure out what is wrong.

Try doing
grep -v dontaudit policy.conf > new-policy
mv new-policy policy.conf

Then load the policy and see what happens.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
