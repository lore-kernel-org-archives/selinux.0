From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Christopher Carney" <ccarney@seacorp.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Configure: error: *** libwrap missing
Date: Fri, 2 May 2003 13:22:21 +1000
References: <001401c3101b$2287ea80$e501a8c0@CarneyC>
In-Reply-To: <001401c3101b$2287ea80$e501a8c0@CarneyC>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305021322.21126.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 May 2003 05:52, Christopher Carney wrote:
> "checking for libwrap. configure: error: *** libwrap missing

The best thing to do is to install the package that provides the libwrap 
header files and libwrap.a.  libwrap allows control over which IP addresses 
and domains can connect to sshd, this is desirable functionality.

> So I went ahead and ran. /configure for XOpenSSH which worked fine.

./configure should detect the lack of libwrap and you should then be able to 
compile it with the SE patch.  You can compile the patched programs without 
using the supplied scripts, it requires a little more effort but the result 
will be equally good.

Probably the best thing to do however would be to create rpms of the patched 
software for Mandrake.  Or maybe Carsten has some SuSE rpms that would work 
for you.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
