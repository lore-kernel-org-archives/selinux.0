Subject: Re: Lets try this again: Advantages and Disadvantages of
	Overtyping a policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Dave Quigley <dquigley@gmail.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1172003869.20576.230.camel@sgc.columbia.tresys.com>
References: <f888952b0702161308y4a373559n581ea8a61de355ee@mail.gmail.com>
	 <1172003869.20576.230.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 15:47:12 -0500
Message-Id: <1172004432.14363.225.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 20:37 +0000, Christopher J. PeBenito wrote:
> On Fri, 2007-02-16 at 16:08 -0500, Dave Quigley wrote:
> > OK onto my actual question. I was wondering what advantages and
> > disadvantages there are to having too many types in a policy. I can
> > see if you have too many the allow rules to allow interaction within
> > the application itself can be excessive. However it also seems to me
> > that by having more types for the application you can have more
> > control over restriction the application. You see this in come
> > policies where they have separate types for their files in /var /etc
> > and /log however you don't see it for that many applications. I would
> > just like to hear people's thoughts on this.
> 
> It depends on your security goals.  The question is: does the extra
> granularity help you better attain your security goals?
> 
> Take bin_t for example.  We could have a type for every single program,
> but we don't because these are all system binaries that execute in the
> caller's domain.  So even if the domain can execute any of the programs,
> it is still limited by the access the domain has.
> 
> Something like foo_tmp_t vs. foo_log_t vs. foo_conf_t usually is
> straightforward since the app will tend to have create, read, write, and
> delete access for foo_tmp_t, create and append for foo_log_t, and just
> read for foo_conf_t.  The objects clearly have different security
> attributes, thus get different types.  Adding multiple types for each of
> foo's logs would gain granularity but wouldn't gain anything
> security-wise since foo still needs the same access for each type (they
> have the same security attributes).

Type preservation is also an issue that needs to be considered for
fine-grained typing, as policy can only distinguish based on the
creating process' domain and/or the parent directory type, so if you
have a single process creating multiple files in the same parent
directory and you want them to have different types, you need the
program to be SELinux-aware (i.e. use setfscreatecon(3)).
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
