Date: Wed, 8 Oct 2003 09:52:13 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: patched wdm (new API)
Message-ID: <20031008095209.D11916@lemuria.org>
References: <20031002145936.A16412@lemuria.org> <87isn0a5ot.fsf@peti.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87isn0a5ot.fsf@peti.cryp.to>; from simons+sel@cryp.to on Wed, Oct 08, 2003 at 03:17:38AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 08, 2003 at 03:17:38AM +0200, Peter Simons wrote:
>  > I have patched the current wdm version so we have again an
>  > SELinux-aware graphical login available.
> 
> Out of curiosity: wdm requires WindowMaker as well, right? 

No, it does require some of wmaker's libraries, but not wmaker itself,
and it will happily launch any other window manager, KDE or Gnome.


> Is there any chance these patches could be applied to xdm as well?

Absolutely. The patch is trivial enough and wdm was chosen by me
explicitly because it is much simpler and much closer to xdm then the
other (kdm, gdm) login managers.

Take a look at the patch - most of it is for configure and makefile stuff, 
the actual code change is about a dozen lines.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
