From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Peter Simons <simons+sel@cryp.to>, SELinux@tycho.nsa.gov
Subject: Re: patched wdm (new API)
Date: Wed, 8 Oct 2003 15:05:33 +1000
References: <20031002145936.A16412@lemuria.org> <87isn0a5ot.fsf@peti.cryp.to>
In-Reply-To: <87isn0a5ot.fsf@peti.cryp.to>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310081505.33814.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 11:17, Peter Simons wrote:
>  > I have patched the current wdm version so we have again an
>  > SELinux-aware graphical login available.
>
> Out of curiosity: wdm requires WindowMaker as well, right?
>
> Is there any chance these patches could be applied to xdm as well?

Have you tried the PAM module that Dan wrote?  It should work for xdm as long 
as it's PAM enabled.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
