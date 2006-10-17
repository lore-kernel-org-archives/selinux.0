Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
In-Reply-To: <000501c6f151$147d5180$cc0a010a@tcssec.com>
References: <000501c6f151$147d5180$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 09:56:30 -0400
Message-Id: <1161093390.29584.27.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-16 at 13:29 -0500, Venkat Yekkirala wrote:
> > > > >
> > > > > allow apache_t  httpd_ipsec_t:association { polmatch };
> > > > >
> <snip>
> >
> > The above rule clearly shows a relationship between a domain(socket?)
> > and a SPD entry.  It does not show a relationship between a packet and
> > an association.
> 
> This relationship is implicit in that a packet from apache_t can only
> use an association labeled apache_t. This would be currently shown in the
> SELinux policy itself as:
> 
> allow apache_t apache_t:association { sendto };
> 
> We did talk about moving this "implicit" relationship into the kernel itself
> essentially eliminating the association indirection for SAs.

Exactly, implicit isn't sufficient, because we won't be able to specify
that http packets can go over the apache association but not dns
packets.

> > When analyzing policy, the labeling is ignored until the very
> > end where
> > you verify that the labeling fits the policy.   If you don't know what
> > is in the SPD, you can not know which packets can go over the
> > association by looking at the above rule.
> 
> Can you please explain this in terms of file_contexts in case I am missing
> something here (you seem to be saying in the above para that: If you don't
> know what's in the file_contexts db, you can not know which procs can write
> to which files).

No, that's not what I'm saying.  Its already understood that, for
example, shadow_t is for the shadow passwords.  There are explicit rules
for allowing a domain access to shadow passwords in the TE policy.  For
the purposes of analysis, we don't need to know which files have this
label until after we have determined that the policy rules match our
security goals.  Then after that, we can look at the labeling to make
sure that it lines up with the policy.

Its tough to put this in terms of file contexts, because it doesn't work
like ipsec, but I'll try.  Currently we have something like this:

TE:
allow passwd_t shadow_t:file rw_file_perms;
allow passwd_t etc_t:file r_file_perms;
allow checkpasswd_t shadow_t:file r_file_perms;
allow checkpasswd_t etc_t:file r_file_perms;

FC:
/etc(/.*)? system_u:object_r:etc_t
/etc/shadow -- system_u:object_r:shadow_t

where by looking at only the TE rules, you can see a relationship
between the password and checkpasswd domains and the shadow_t and etc_t
files.  By the policy design, we know that etc_t are general system
config files, and shadow_t are the shadow passwords.  Then after we're
done verifying our security goals in the TE rules, we can check the FC
to see that the labeling is indeed valid, and then label the
filesystems.

Now pretend that file contexts are instead loaded into the kernel and
each fc entry is labeled and has rules for access.

TE:
allow passwd_t passwd_fc_entries_t:fc fcmatch;

FC:
system_u:object_r:passwd_fc_entries_t r /etc(/.*)?
system_u:object_r:passwd_fc_entries_t rw /etc/shadow
system_u:object_r:checkpasswd_fc_entries_t r /etc(/.*)?
system_u:object_r:checkpasswd_fc_entries_t r /etc/shadow

See the difference?  Now we can't tell whats going on by looking at the
TE rules because we're putting policy somewhere else.  It doesn't matter
that these other rules also happen to be in the kernel; the point is
that they aren't in the TE policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
