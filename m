Date: Tue, 12 Nov 2002 19:53:16 +0100
From: Tom <tom@lemuria.org>
To: K VAMSHI KRISHNA <Vamshi.Krishna@cmcltd.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: SELinux and Tomcat web server
Message-ID: <20021112195316.A15495@lemuria.org>
References: <1475.210.212.217.4.1037111289.squirrel@webmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475.210.212.217.4.1037111289.squirrel@webmail>; from Vamshi.Krishna@cmcltd.com on Tue, Nov 12, 2002 at 07:58:09PM +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 12, 2002 at 07:58:09PM +0530, K VAMSHI KRISHNA wrote:
> knowledge involves unzipping/extracting class files from some jar files
> in the lib and work folders under the jakarta folder. It also needs
> configuring the acess to the Java subsystem by Tomcat process.
> Before starting on this, I thought of inquiring if any of you have
> already gone through it. I would be grateful for any help in this
> context. Any pointers in configuring the Java subsystem will also be
> quite useful. Thanks in advance,

As part of my work on the Apache policy, I've taken a few looks at
tomcat, too, especially because we are also using Tomcat on one of the
systems that I'd love to move to SELinux one day.

I don't have much in this direction so far, so if you want to start
working on it, I'd be thrilled. Or you can wait until I come around to
it.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
