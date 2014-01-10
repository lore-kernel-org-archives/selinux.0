Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0ALiLsC032048
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 16:44:21 -0500
Received: by mail-wg0-f54.google.com with SMTP id x13so1718880wgg.9
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 13:44:19 -0800 (PST)
Message-ID: <1389390257.20258.71.camel@x220.localdomain>
Subject: Re: Web Application access to files in /mnt/
From: Dominick Grift <dominick.grift@gmail.com>
To: Ken Smith <kens@kensnet.org>
Date: Fri, 10 Jan 2014 22:44:17 +0100
In-Reply-To: <52D0613F.3030805@kensnet.org>
References: <52D0613F.3030805@kensnet.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2014-01-10 at 21:08 +0000, Ken Smith wrote:
> Hi All, I could do with some simple guidance. I have a web application, 
> written in Perl, that is part of MythTV. It can stream video from files 
> mounted in /mnt.
> 

In this case the issue might not be so simple. You have mounted a
partition under /mnt/ or /mnt/store0 that currently has no SELinux
metadata stored with its objects.

So either you just formatted that partition, or it comes from a system
that does not support SELinux.

The question is which assumptions to make. Will this just need to work
in this specific scenario or in any scenario?

I will give you a simple solution that might make it work for partitions
mounted under /mnt that have object that have no SELinux metadata stored
with it.

mkdir ~/test; cd ~/test
cat > test.te <<EOF
policy_module(test, 1.0.0)
gen_require(\` type file_t; ')
apache_content_template(test)
list_dirs_pattern(httpd_test_script_t, file_t, file_t)
read_files_pattern(httpd_test_script_t, file_t, file_t)
EOF
make -f /usr/share/selinux/devel/Makefile test.pp
sudo semodule -i test.pp

Then use the following command to label the perl script appropriately
(replace the path in this example with the actual path to the script):

sudo semanage fcontext -a -t httpd_test_script_exec_t -f --
"/var/www/cgi-bin/mythweb\.pl"
sudo restorecon -v /var/www/cgi-bin/mythweb.pl

Then see if it works (it will probably not work yet)

if it still does not work then you might want to quickly test it in
permissive mode by running:

setenforce 0
<<reproduce/retest the webapp>>
setenforce 1

then use: sudo ausearch -m avc,user_avc,selinux_err -ts recent |
audit2allow -M test_addon; semodule -i test_addon.pp

Hopefully that will put all the additional rules into the test_addon.pp
module and install that along side the test.pp module

That might make it work.

This is a quick hack though the issue is not as simple as it seems but
you havent given me enough information for me to give a better solution

What we did above was we created a new "selinux sandbox" called
httpd_test_script_t and associated that with
the /var/www/cgi-bin/mythweb.pl script. Then we expanded that selinux
sandbox a bit so that it can read directory and file object that have no
selinux security metadata associated with it.

The goal of this was to not break the existing httpd_sys_script_t
selinux sandbox in which the webapp was running previously. This because
that selinux sandbox is used by other generic web apps as well and we
dont want to give them these permissions, only mythweb.pl

> The report from SElinux is
> 
> Source Context                system_u:system_r:httpd_sys_script_t:s0
> Target Context                system_u:object_r:file_t:s0
> Target Objects                /mnt/store0 [ dir ]
> Source                        mythweb.pl
> 
> What would be the best approach. Should I relabel the files in /mnt or 
> create a module like this
> 
> # grep mythweb.pl /var/log/audit/audit.log | audit2allow -M mypol
> # semodule -i mypol.pp
> 
> Thanks in advance
> 
> Ken
> 
> 
> 
