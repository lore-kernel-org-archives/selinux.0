Date: Mon, 2 Jul 2001 08:50:32 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: cslater@wcnet.org
cc: SELinux@tycho.nsa.gov
Subject: Re: Slackware
In-Reply-To: <200106272310.f5RNAib05790@woody.wcnet.org>
Message-ID: <Pine.SOL.3.95.1010702084703.13449A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Jun 2001 cslater@wcnet.org wrote:

> I tried it on slackware. I also killed my box flat dead. SELinux as far as i 
> can tell requires PAM. PAM Kills slackware. Do not use PAM and slackware. I 
> tried. Gave errors when you tried to login, refused to let you login. I 
> reformated and reinstalled. Ive been talking to people cin the forum and they 
> say that they are not going to support PAM till it becomes more developed and 
> mature. They say that there are too many security problems at the moment, and 
> that it requires a entire rebuild of most of the a1 and possible n1 series. I 
> would generaly stay away from SELinux.

You should be able to work around this problem simply by disabling PAM
in the util-linux MCONFIG before building the modified login program.
SELinux itself doesn't depend on PAM, but the modified login program
provided in the SELinux distribution is configured with PAM enabled
by default, because we're using RedHat, and RedHat uses PAM.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
