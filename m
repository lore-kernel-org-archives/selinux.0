Subject: Re: missing avc message field names
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <20070129141019.98242.qmail@web51502.mail.yahoo.com>
References: <20070129141019.98242.qmail@web51502.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 09:35:28 -0500
Message-Id: <1170081328.8720.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-29 at 06:10 -0800, Steve G wrote:
> Hi,
> 
> I am in the process of working on the audit parsing library. The specifications
> for the parser have been posted for about a year:
> 
> http://people.redhat.com/sgrubb/audit/audit-parse.txt
> 
> In order to allow bindings in many programming languages, it was decided to
> abstract much of the audit format and just present an opaque API that presents
> the data as name/value pairs that can be iterated through. So far, everything is
> working fine for all audit messages except AVCs. The reason being is that there
> are fields in the record that do not have a name. For example:
> 
> type=AVC msg=audit(1169743468.302:3604): avc:  denied  { sys_resource } for 
> pid=4002 comm="semodule" capability=24 scontext=system_u:system_r:semanage_t:s0
> tcontext=system_u:system_r:semanage_t:s0 tclass=capability
> 
> The parser uses ' ' as the separator. So the 4th field is denied al by itself.
> The 6th field is sys_resource all by itself. Currently the parser throws those
> fields away because they do not follow the name=value convention. But I think
> they are fields that we really want to keep.
> 
> Would anybody object to making these follow the name=value format?
>
> If this is impossible, I can special-case AVCs and pick out the 4th and 6th
> fields. But the API will follow name/value convention. So, what would everyone
> want to call the 4th & 6th field's names?

I don't think it is "impossible", but it would require updating of e.g.
audit2allow, audit2why, madison/sepolgen, setroubleshoot and seaudit
(setools).

Are you proposing changing the raw kernel output format as well, or just
the auditd-generated output format?  

The 4th field could be called "result=".  It has two possible values,
"denied" or "granted".

The 6th field could be called "perms=".  Its value is a space separated
list, presently delimited by { } brackets.  I suppose it could be comma
separated and space delimited instead if that matters.

"for" could likely be dropped from the message altogether.

"avc:" is redundant with type=AVC, but we don't get the latter in the
raw kernel output, so it is useful for messages emitted when auditd is
not running (either before auditd starts, after it exits, or when not
using auditd at all).

> Just an FYI, I am hoping to release the initial libauparse later this week. It
> should have python bindings, too.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
