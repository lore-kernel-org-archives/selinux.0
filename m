From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [PATCH] refpolicy: experimental X policy -v2
Date: Thu, 22 Mar 2007 21:53:02 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
References: <45B938EE.8010303@tycho.nsa.gov> <1174510410.19924.23.camel@sgc.columbia.tresys.com> <4601CDF3.7040905@tycho.nsa.gov>
In-Reply-To: <4601CDF3.7040905@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703222153.07131.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 22 March 2007 11:29, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> The fast user switching support in rawhide runs multiple xservers on
> virtual consoles; having them all be xdm_xserver_t is problematic.

Why is it more of a problem when multiple xservers run at the same time?

I agree that the current situation is far from ideal, but don't understand how 
fast user switching has made it any worse.

> Other ideas: have the display manager always running on the first
> virtual console, and launch the user servers on other consoles.

In that case why not have multiple XDM programs running, one per VC.  Then the 
login process could be to graphically ask the user for their user-name and 
password, then kill the X server and start a new one for the user's context.

> Or 
> maybe we should go back to a text-based login only running X through
> startx.

No.  But I think that it would be viable to have a modified text-mode login 
program start X automatically on the same VC.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
