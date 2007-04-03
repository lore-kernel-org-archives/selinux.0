Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l33Er6qX029010
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 10:53:06 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l33Er3Fg016055
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 14:53:04 GMT
Message-ID: <46126A3E.2080909@redhat.com>
Date: Tue, 03 Apr 2007 10:52:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Yong Lee <ylee@eqo.com>
CC: selinux@tycho.nsa.gov
Subject: Re: runcon problems
References: <012201c77006$615c44a0$aa5a0a0a@yonglaptop>
In-Reply-To: <012201c77006$615c44a0$aa5a0a0a@yonglaptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yong Lee wrote:
>
> Hi all,
>
> I知 rather new to selinux and was hoping that someone could help me 
> with a problem I am having. I知 running on redhat WS 4 2.6.9-42. I知 
> trying to get a php based web application to make a system call to do 
> a java compile. I was getting a bunch of avc issues trying to do this 
> and rather than try to change the selinux policy I was hoping to make 
> use of the runcon command to run a script which would do my java 
> compile call.
>
> So I have a script that looks something like this :
>
> #!/bin/sh
>
> exec /usr/bin/java 頬ar $2 $3 $4 $5
>
> and I知 trying to call it using a system call from php :
>
> /usr/bin/runcon /home/test/runjava a b c d
>
> denied { write } for pid=727 comm="runcon" name="exec" dev=proc 
> ino=47644693 scontext=root:system_r:httpd_sys_script_t 
> tcontext=root:system_r:httpd_sys_script_t tclass=file
>
> when I edit my targeted policy and recompile to allow the write on 
> exec, I get :
>
> Mar 26 16:54:14 localhost kernel: audit(1174953254.268:1216): avc: 
> denied { setexec } for pid=1097 comm="runcon" 
> scontext=root:system_r:httpd_sys_script_t 
> tcontext=root:system_r:httpd_sys_script_t tclass=process
>
> I was going to add
>
> allow httpd_sys_script_t self:process setexec;
>
> to the policy rules but I知 thinking that this may not be a good idea 
> and there must be a better way to get this done. I知 hoping that some 
> of u gurus with a lot more experience in this area could help shed 
> some light on the best way of allowing my php script to successfully 
> call the java binary without making so many changes to the existing 
> selinux policy.
>
Confined apps can not use the runcon process. You have two choices.

1. Either add rules to a local.te file
2. turn off confinement for your cgi script.
chcon -t httpd_unconfined_script_exec_t PATHTOCGI

In RHEL5 you could:
1. Build a policy for your cgi script to be able to run the java compiler.

Create a te file that looks like
#cat javacgi.te
policy_module(javacgi,1.0.0)

########################################
#
# Declarations
#

apache_content_template(javacgi)

Create an fc file that looks like:
# cat javacgi.fc
/var/www/cgi-bin/javacgi.cgi -- 
gen_context(system_u:object_r:httpd_javacgi_script_exec_t,s0)

Compile them and load the policy

# make -f /usr/share/selinux/devel/Makefile
# semodule -i javacgi.pp
# restorecon /var/www/cgi-bin/javacgi.cgi

Go to permissive mode

#setenforce 0

Run your cgi tests.

Use audit2allow -R to generate appropriate allow rules

# grep javacgi /var/log/audit/audit.log | audit2allow -R >> javacgi.te
# make -f /usr/share/selinux/devel/Makefile
# semodule -i javacgi.pp

Turn back on enforcing mode

# setenforce 1


> thanks,
>
> Yong.
>
> Yong Lee
>
> Developer
>
> ylee@EQO.com <mailto:ylee@EQO.com>
>
> <http://www.eqo.com/>
>
> direct: +1.604.273.8173 x113
>
> mobile: +1.604.418.4470
>
> fax: +1.604.273.8172
>
> web: www.EQO.com <http://www.eqo.com/>
>
> EQO ID: yonglee
>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
