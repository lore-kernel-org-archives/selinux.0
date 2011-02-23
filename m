Subject: Re: type_datum changed from define_type() and type_write() ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w158CDE61B212AC89099502ABDB0@phx.gbl>
References: <SNT139-w158CDE61B212AC89099502ABDB0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Feb 2011 09:15:21 -0500
Message-ID: <1298470521.13789.9.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-02-23 at 08:30 +0000, HarryCiao wrote:
> Hi SELinux experts,
> 
> I am trying to add a new rule "typesocket" to checkpolicy which does
> something like "typesocket syslogd_t syslogd_s_t", where syslogd_t is
> the domain for the syslog daemon and the syslogd_s_t would be used to
> label the AF_UNIX socket created by syslog daemon(so that it no longer
> inherits the creator's sid).
> 
> I would like to add two extra members in the binary representation for
> the syslogd_t's type_datum structure: a u32 "socket_type_len" field
> before the string of "syslogd_t", and the socket type string of
> "syslogd_s_t" right after the "syslogd_t" string.
> 
> Two new members have been added to the type_datum structure: a char *,
> "socket_type_str" and a uint32_t, "socket_type_len". The newly added
> define_typesocket() in policy_define.c is used to handle this new
> typesocket rule, it will save the string and length of "syslogd_s_t"
> to syslogd_t's type_datum->socket_type_str and socket_type_len fields.
> While the type_write() in libsepol wr! ite.c will try to save
> type_datum->socket_type_str right after the key of the current
> type_datum if type_datum->socket_type_len is not zero.
> 
> It seems easy, however, I've run into a strange problem, that the
> type_datum structure used in define_typesocket() during parsing seems
> to be different from the one used by type_write() when writing into
> binary representations. I put some printfs in these two functions, the
> results are:
> 
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> define_typesocket, syslogd_t.s.value: b09
> define_typesocket, syslogd_t.socket_type_len: b
> define_typesocket, syslogd_t.socket_type_str: syslogd_s_t
> define_typesocket, syslogd_s_t.s.value: b07
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 24) to
> policy.24
> type_write, key:syslogd_s_t
> s.value: 22d
> type_write, key:syslogd_t
> s.value: ce7
> socket_type_len: 0socket_type_str: (null)
> 
> Where we can see that when "typesocke t syslogd_t syslogd_s_t" is
> parsed, the s.value for the syslogd_t and syslogd_s_t are b09 and b07
> respectively, and the reference to "syslogd_s_t" has been properly
> setup in syslogd_t's type_datum. However, when writing binary
> representations their s.value have been changed to ce7 and 22d, and
> the reference to "syslogd_s_t" in syslogd_t's type_datum has been
> zeroed.
> 
> Any clues??

First, I think your approach is wrong - you should declare syslogd_s_t
using a normal type declaration so that it is defined as a discrete
type, and then simply use the existing type_transition statement to
express that you want to label newly created sockets with a type other
than the creator's type.  Then you just need to implement the logic in
the kernel to invoke security_transition_sid() when computing socket
labels and you do not need any new language constructs.

But with regard to your problem, understand that types (and other
symbols) are first assigned temporary values during module compilation,
then they are mapped to their final values during module
linking/expansion into a final policy.  So whenever you add new state,
you have to preserve it and map it properly during the link/expand
stages.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
