Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5RCJ7rT007959
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 08:19:08 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5RCIq5h008635
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 12:18:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Policy for webalizer
Date: Sun, 27 Jun 2004 22:18:31 +1000
Cc: Yuichi Nakamura <himainu-ynakam@miomio.jp>, selinux@tycho.nsa.gov
References: <200406271133.i5RBXpH0029485@mms-r00.iijmio.jp>
In-Reply-To: <200406271133.i5RBXpH0029485@mms-r00.iijmio.jp>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Xsr3A2D8R/qWZHL"
Message-Id: <200406272218.31524.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Xsr3A2D8R/qWZHL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 27 Jun 2004 21:33, Yuichi Nakamura <himainu-ynakam@miomio.jp> wrote:
> I found that webalizer does not work from cron on FedoraCore2.
>
> It seems that there is no policy for webalizer.
> I wrote policy for webalizer.
> I tested it from command line and cron.
> Please use.

I think you should use etc_domain(webalizer) instead of defining 
webalizer_conf_t and var_lib_domain(webalizer) instead of webalizer_write_t.

We could have /var/www/usage labelled as httpd_sys_content_t.  That gives less 
types (less pain) for no significant decrease in security.  I should probably 
make a similar change to calamaris_t.

For access to locale_t you want read_locale(webalizer_t).

As a general rule we don't want to allow any daemons access to the 
administrator console if we can avoid it.  I'm not sure what the best thing 
to do for webalizer is in this regard.

I've made some minor changes, please check the attached files and tell me what 
you think.


PS  I've been running webalizer in logrotate_t domain for a couple of years.  
This isn't ideal though as I needed to put some entries in custom.te for it - 
not something I could distribute.  Having a webalizer_t is a good 
improvement.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Xsr3A2D8R/qWZHL
Content-Type: text/plain;
  charset="iso-8859-1";
  name="webalizer.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="webalizer.te"

##webalizer_t: domain for webalizer
# 2004.6.19
# by Yuichi Nakamura (ynakam @ selinux.gr.jp)

application_domain(webalizer)
# to use from cron
system_crond_entry(webalizer_exec_t,webalizer_t)
role system_r types webalizer_t;

##type definision
# type for usage file
type webalizer_usage_t,file_type,sysadmfile;
# type for /var/lib/webalizer
type webalizer_write_t,file_type,sysadmfile;
# type for webalizer.conf
etc_domain(webalizer)

#read apache log
allow webalizer_t var_log_t:dir r_dir_perms;
r_dir_file(webalizer_t, httpd_log_t)

#r/w /var/lib/webalizer
var_lib_domain(webalizer)

#read /var/www/usage
create_dir_file(webalizer_t, httpd_sys_content_t)

#read system files under /etc
allow webalizer_t { etc_t etc_runtime_t }:file { getattr read };
read_locale(webalizer_t)

# can use tmp file
tmp_domain(webalizer)

# can read /proc
read_sysctl(webalizer_t)
allow webalizer_t proc_t:dir { search };
allow webalizer_t proc_t:file r_file_perms;

# network
can_network(webalizer_t)

#process communication inside webalizer itself
general_domain_access(webalizer_t)

allow webalizer_t self:capability { dac_override };

--Boundary-00=_Xsr3A2D8R/qWZHL
Content-Type: text/plain;
  charset="iso-8859-1";
  name="webalizer.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="webalizer.fc"


/usr/bin/webalizer		system_u:object_r:webalizer_exec_t
/var/lib/webalizer(/.*)?	system_u:object_r:webalizer_var_lib_t
/etc/webalizer.conf		system_u:object_r:webalizer_etc_t

--Boundary-00=_Xsr3A2D8R/qWZHL--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
