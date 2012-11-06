Date: Wed, 7 Nov 2012 09:53:43 +1000 (EST)
From: Daniel Black <daniel.black@openquery.com>
To: SELinux@tycho.nsa.gov
Message-ID: <918230378.1546.1352246023692.JavaMail.root@zimbra.lentz.com.au>
In-Reply-To: <1109499143.1536.1352238861513.JavaMail.root@zimbra.lentz.com.au>
Subject: semanage fails when conflicting types are in current or
 subdirectory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Just a heads up to anyone who comes across as similar problem.

On a fairly basic centos 6.3 machine:
selinux-policy.noarch                                 3.7.19-155.el6_3.4                        @updates                                
selinux-policy-targeted.noarch                        3.7.19-155.el6_3.4                        @updates       

$ sudo semanage permissive -a munin_services_plugin_t
/usr/sbin/semanage: compilation failed:
/usr/share/selinux/devel/include/Makefile:151: *** multiple target patterns.  Stop.

line 151 is 
all: $(all_packages)

It turns out I had a t.te in the currently directory containing
#============= munin_services_plugin_t ==============
allow munin_services_plugin_t unconfined_t:sem { unix_read unix_write };

with its corresponding t.pp file. As semanage called make -f /usr/share/selinux/devel/include/Makefile some of the current directory was significant. As the makefile calls find some of the subdirectories could also be significant. I created an empty directory and ran semanage from that directory and it worked ok.

The order and cause could be slightly off here. In the rush to get a right solution I didn't record the details that well.

-- 
Daniel Black, Engineer @ Open Query (http://openquery.com)
Remote expertise & maintenance for MySQL/MariaDB server environments.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
