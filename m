Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>,
   "'Chad Hanson'" <chanson@TrustedCS.com>
In-Reply-To: <1099417155.23756.112.camel@pham.columbia.tresys.com>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com>
	 <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil>
	 <4186DCE7.9030401@tresys.com>
	 <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
	 <1099417155.23756.112.camel@pham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099418564.31739.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 13:02:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 12:39, Karl MacMillan wrote:
> Also,
> where would you put the trust boundaries if not at process boundries? Is
> it possible to truly reduce the trust between two sections of code in
> the same process image? [these are not rhetorical questions - I'm really
> asking for some clarification]

I agree that the trust boundary has to be at the process boundary.  What
I was saying is that merely re-factoring your application code into
multiple helpers doesn't necessarily establish a real barrier to
arbitrary mis-use of the helpers by the calling application.  You have
to think carefully about the interface between them.  Of course, if they
aren't separate processes, then that interface is obviously arbitrarily
wide and uncontrolled, as you say.

> I don't think
> that it is necessarily the case that it is worse to run in a domain with
> the maximal set of permissions. What are the real benefits to converting
> samba, for example, to use dynamic context transitions instead of making
> it a user-space object manager? It doesn't seem to reduce the amount of
> trust placed in samba, but I may be missing something.

The amount of trust placed in samba is the same, but the dynamic context
transition allows the kernel to handle the mediation directly and
atomically with respect to the file access.  Otherwise, you have to
duplicate the checking in samba (which will still ultimately get the
decisions from the kernel via selinuxfs) and deal in some way with race
conditions.  Keep in mind that we are talking about user-writable
directories that are being exported by samba.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
