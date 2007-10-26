From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: What domain should the X server run in
Date: Fri, 26 Oct 2007 22:52:27 +1000
Cc: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <4720D211.1000507@tycho.nsa.gov>
In-Reply-To: <4720D211.1000507@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710262252.31838.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 October 2007 03:27, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> Is the X server part of the user's session or not?

It probably would be best to have the X server run in a domain specific to the 
user.  Even without the domain-type issues if we want to use labelled 
networking to control access to X servers (let's not assume there is a strict 
1:1 mapping of X servers to user sessions) in a MLS/MCS environment then 
having an X server instance per user makes sense.

> If it is, then it should always run as user_xserver_t, and the display
> managers should be "fixed" to label the X server with the user's context
> at login time.
>
> It if isn't, then it should always run in the same domain, and
> startx/xinit should be "fixed" to transition into this context.
>
>  From my perspective I would favor the latter option for now since it's
> easier to write policy for.  The user's individual windows can be
> labeled with a per-user type, maintaining separation.

Why would either option be easier for policy writing?  Getting both to work 
(as has currently been done) is tricky - and we have had repeated breakage 
along the way.  For ease of policy writing we would support exactly one of 
the options.

I think that having the display manager start a new X server for each login 
will give the best result.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
