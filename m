Subject: Re: Trouble building Policy-1.16
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Justin Friel <capn_shoe@yahoo.com>
Cc: SELinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20040825222322.32725.qmail@web60002.mail.yahoo.com>
References: <20040825222322.32725.qmail@web60002.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1093524996.9280.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 26 Aug 2004 08:56:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-08-25 at 18:23, Justin Friel wrote:
> --- Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> 
> > On Tue, 2004-08-24 at 15:25, Justin Friel wrote:
> > > I am having a hard time getting policy-1.16 to
> > compile
> > > on a "Linux from scratch" system.  When I try to
> > > compile the strict policy, I get the following
> > output:
> > > 
> > > ...
> > > /usr/bin/checkpolicy -o policy.18 policy.conf
> > > /usr/bin/checkpolicy:  loading policy
> > configuration
> > > from policy.conf
> > > types/file.te:92:ERROR 'syntax error' at token
> > ':f' on
> > > line 3066:
> > > allow auth shadow_t:file { getattr read };
> > > type shadow_t, file_type;
> > > /usr/bin/checkpolicy:  error(s) encountered while
> > > parsing configuration
> > > make: *** [policy.18] Error 1
> > 
> > That looks very odd.  Can you send your entire
> > policy.conf file to me?
> 
> Sorry if this is a repost, I sent this in earlier this
> morning and haven't seen it hit the list yet. 
> 
> I bzipped and attached the policy.conf.  As for the
> warnings while bulding checkpoliy, they seem harmless
> to me, but here they are.

In general, don't repost - send a note to selinux-team@tycho.nsa.gov or
owner-selinux@tycho.nsa.gov if you think you have posted and it hasn't
shown up after a while (but be patient, please).

Interesting.  Your attached policy.conf compiles fine with a checkpolicy
built on Fedora, but this looks like a scanner bug.  What version of lex
are you using (we are using flex-2.5.4a-33 on Fedora)?  Your scanner is
handling the ":f" as a single token rather than splitting it up as ":"
and "file".  Looking at policy_scan.l, I noticed that the IPV6_ADDR
entry seems dangerously close to treating this as a token, but not quite
(it would match :f:).

Rather than treating an entire ipv6 address as a single token, we could
just scan the hexval components and separating colons as individual
tokens and define ipv6 address in the grammar, as we do with
ipv4_addr_def.  That would seem safer.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
