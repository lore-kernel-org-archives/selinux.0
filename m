Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TEAA7d011112
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 09:10:10 -0500
Received: from web51502.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0TEBCxX013162
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 14:11:12 GMT
Message-ID: <20070129141019.98242.qmail@web51502.mail.yahoo.com>
Date: Mon, 29 Jan 2007 06:10:18 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: missing avc message field names
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am in the process of working on the audit parsing library. The specifications
for the parser have been posted for about a year:

http://people.redhat.com/sgrubb/audit/audit-parse.txt

In order to allow bindings in many programming languages, it was decided to
abstract much of the audit format and just present an opaque API that presents
the data as name/value pairs that can be iterated through. So far, everything is
working fine for all audit messages except AVCs. The reason being is that there
are fields in the record that do not have a name. For example:

type=AVC msg=audit(1169743468.302:3604): avc:  denied  { sys_resource } for 
pid=4002 comm="semodule" capability=24 scontext=system_u:system_r:semanage_t:s0
tcontext=system_u:system_r:semanage_t:s0 tclass=capability

The parser uses ' ' as the separator. So the 4th field is denied al by itself.
The 6th field is sys_resource all by itself. Currently the parser throws those
fields away because they do not follow the name=value convention. But I think
they are fields that we really want to keep.

Would anybody object to making these follow the name=value format?

If this is impossible, I can special-case AVCs and pick out the 4th and 6th
fields. But the API will follow name/value convention. So, what would everyone
want to call the 4th & 6th field's names?

Just an FYI, I am hoping to release the initial libauparse later this week. It
should have python bindings, too.

Thanks,
-Steve


 
____________________________________________________________________________________
It's here! Your new message!  
Get new email alerts with the free Yahoo! Toolbar.
http://tools.search.yahoo.com/toolbar/features/mail/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
