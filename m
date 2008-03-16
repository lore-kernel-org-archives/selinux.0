Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2GBjvJ9006990
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2008 07:45:57 -0400
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2GBjtcL017794
	for <selinux@tycho.nsa.gov>; Sun, 16 Mar 2008 11:45:55 GMT
Subject: Re: prelink, cron-job and SELinux compliance
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <47D530DC.5030606@redhat.com>
References: <1204970465.4229.10.camel@vogon>  <47D530DC.5030606@redhat.com>
Content-Type: multipart/mixed; boundary="=-oNKjhMYlAlNn/kZ+8YSS"
Date: Sun, 16 Mar 2008 12:45:15 +0100
Message-Id: <1205667915.2932.9.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-oNKjhMYlAlNn/kZ+8YSS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 2008-03-10 at 09:00 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stefan Schulze Frielinghaus wrote:
> > In RHEL/CentOS 5.1 a cron job (/etc/cron.daily/prelink) runs prelink.
> > The cron job itself removes a file (/etc/prelink.cache) if necessary and
> > updates the database. This does not work with the strict SELinux policy.
> > 
> > To solve this I patched the prelink application to
> > use /var/cache/prelink/prelink.cache instead of /etc/prelink.cache
> > This would make it more easier to write SELinux policies. But know my
> > actual question is how to modify the cron job to work properly? All cron
> > jobs on my system are labeled as bin_t. This would mean that
> > system_crond_t needs write/create etc. permissions
> > on /var/cache/prelink. Thats not really nice and I would prefer to
> > create a domain like cron_script_prelink_t for /etc/cron.daily/prelink
> > which gets all the rights to manage /var/cache/prelink.
> > 
> > What are your ideas to handle cron scripts properly?
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> Does labeling the directory cron_var_run_t make it work?
> 
> Please open a bug report on prelink to put the cache file in this new
> directory.

The relabel did not solve the problem (AVCs are attached).

#============= prelink_t ==============
allow prelink_t crond_var_run_t:dir { remove_name add_name };
allow prelink_t crond_var_run_t:file { write rename create setattr };

#============= system_crond_t ==============
allow system_crond_t crond_var_run_t:dir { write remove_name add_name };
allow system_crond_t self:process setfscreate;

Should we create a special type for this purpose (like already
mentioned: cron_script_prelink_t and label the
file /etc/cron.daily/prelink)?

I opened a bug: https://bugzilla.redhat.com/show_bug.cgi?id=437684

cheers
Stefan

PS: Sorry for responding so late but I did not have a Internet
connection during last week.

--=-oNKjhMYlAlNn/kZ+8YSS
Content-Disposition: attachment; filename=prelink.cron
Content-Type: text/plain; name=prelink.cron; charset=utf-8
Content-Transfer-Encoding: 7bit

audit(1205665501.789:1129): avc:  denied  { write } for  pid=24611 comm="rm" name="prelink" dev=hda5 ino=457412 scontext=system_u:system_r:system_crond_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=dir
audit(1205665501.789:1130): avc:  denied  { remove_name } for  pid=24611 comm="rm" name="prelink.force" dev=hda5 ino=457414 scontext=system_u:system_r:system_crond_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=dir
audit(1205665501.790:1131): avc:  denied  { add_name } for  pid=24612 comm="prelink" name="prelink.full" scontext=system_u:system_r:system_crond_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=dir
audit(1205665501.795:1132): avc:  denied  { setfscreate } for  pid=24613 comm="cp" scontext=system_u:system_r:system_crond_t:s0-s0:c0.c1023 tcontext=system_u:system_r:system_crond_t:s0-s0:c0.c1023 tclass=process
audit(1205665506.540:1133): avc:  denied  { add_name } for  pid=24614 comm="prelink" name="prelink.cache.FlNd0C" scontext=system_u:system_r:prelink_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=dir
audit(1205665506.540:1134): avc:  denied  { create } for  pid=24614 comm="prelink" name="prelink.cache.FlNd0C" scontext=system_u:system_r:prelink_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=file
audit(1205665506.541:1135): avc:  denied  { write } for  pid=24614 comm="prelink" path="/var/cache/prelink/prelink.cache.FlNd0C" dev=hda5 ino=457415 scontext=system_u:system_r:prelink_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=file
audit(1205665506.542:1136): avc:  denied  { setattr } for  pid=24614 comm="prelink" name="prelink.cache.FlNd0C" dev=hda5 ino=457415 scontext=system_u:system_r:prelink_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=file
audit(1205665506.542:1137): avc:  denied  { remove_name } for  pid=24614 comm="prelink" name="prelink.cache.FlNd0C" dev=hda5 ino=457415 scontext=system_u:system_r:prelink_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=dir
audit(1205665506.543:1138): avc:  denied  { rename } for  pid=24614 comm="prelink" name="prelink.cache.FlNd0C" dev=hda5 ino=457415 scontext=system_u:system_r:prelink_t:s0-s0:c0.c1023 tcontext=system_u:object_r:crond_var_run_t:s0 tclass=file

--=-oNKjhMYlAlNn/kZ+8YSS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
