Message-ID: <45BE0B8D.4080401@mentalrootkit.com>
Date: Mon, 29 Jan 2007 09:58:21 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: missing avc message field names
References: <20070129141019.98242.qmail@web51502.mail.yahoo.com> <1170081328.8720.63.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1170081328.8720.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2007-01-29 at 06:10 -0800, Steve G wrote:
>> Hi,
>>
>> I am in the process of working on the audit parsing library. The specifications
>> for the parser have been posted for about a year:
>>
>> http://people.redhat.com/sgrubb/audit/audit-parse.txt
>>
>> In order to allow bindings in many programming languages, it was decided to
>> abstract much of the audit format and just present an opaque API that presents
>> the data as name/value pairs that can be iterated through. So far, everything is
>> working fine for all audit messages except AVCs. The reason being is that there
>> are fields in the record that do not have a name. For example:
>>
>> type=AVC msg=audit(1169743468.302:3604): avc:  denied  { sys_resource } for 
>> pid=4002 comm="semodule" capability=24 scontext=system_u:system_r:semanage_t:s0
>> tcontext=system_u:system_r:semanage_t:s0 tclass=capability
>>
>> The parser uses ' ' as the separator. So the 4th field is denied al by itself.
>> The 6th field is sys_resource all by itself. Currently the parser throws those
>> fields away because they do not follow the name=value convention. But I think
>> they are fields that we really want to keep.
>>
>> Would anybody object to making these follow the name=value format?
>>
>> If this is impossible, I can special-case AVCs and pick out the 4th and 6th
>> fields. But the API will follow name/value convention. So, what would everyone
>> want to call the 4th & 6th field's names?
> 
> I don't think it is "impossible", but it would require updating of e.g.
> audit2allow, audit2why, madison/sepolgen, setroubleshoot and seaudit
> (setools).
> 

And if the library doesn't handle old format it makes it hard to choose 
it for a project. In madison I wrote a small parsing library that 
handles syslog and auditd logs - I can't imagine dropping that for the 
audit library if it would mean losing compatibility for everything 
before this format change (i.e., all currently shipping selinux systems).

I'd rather the audit parsing library make it easier to preserve 
backwards compatibility with old log formats rather than harder 
(including audit messages that show up in syslog).

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
