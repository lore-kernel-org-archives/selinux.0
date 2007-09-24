Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8OCjqc7017145
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 08:45:52 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8OCjpfc013950
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 12:45:51 GMT
Subject: Re: chcon -l permission
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD49A287@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD49A287@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Mon, 24 Sep 2007 12:44:02 +0000
Message-Id: <1190637842.15178.24.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-09-22 at 17:05 -0700, Clarkson, Mike R (US SSA) wrote:
> I have a java process running in a domain named frontgate_t, which reads
> files and determines the correct classification/compartment level of the
> file based upon its contents. The java process then relabels the file to
> the correct level using "chcon -l ...". It can both upgrade or downgrade
> the level of the file
> 
> I'm getting file relabelfrom and relabelto denials in the audit log that
> I can't get past. I've provided the allow rule indicated by audit2allow.
> At first I thought this was an mls constraint issue. I expect that the
> following mls privileges would be required:
> 	mls_file_upgrade(frontgate_t)
> 	mls_file_downgrade(frontgate_t)
> 	mls_context_translate_all_levels(frontgate_t) (maybe needed??)
> 
> I provided all of these, and then progressively added more and more mls
> privileges until I had provided them all. Next, I gutted the mls file
> that contains all of the mls constraints to once and for all convince
> myself that this wasn't an mls constraint issue.
> 

> avc:  denied  { relabelfrom }
[...]
> scontext=m252_u:system_r:frontgate_t:s4:c0.c255
           ^^^^^^
> tcontext=root:object_r:import_datasources_t:s4:c10
           ^^^^
You hit the SELinux user identity equality constraint: m252_u != root.
You would need domain_obj_id_change_exemption(frontgate_t) to make this
work.  Or, run in system_u:system_r:frontgate_t:s4:c0.c255.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
