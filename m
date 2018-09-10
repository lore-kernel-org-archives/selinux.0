To: Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
Date: Mon, 10 Sep 2018 13:47:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/10/2018 01:13 PM, Ted Toth wrote:
> We currently have code running on el6 that does a MLS dominance check by 
> calling security_compute_av_raw with the security object class 
> SECCLASS_CONTEXT with permission CONTEXT__CONTAINS as you can see in the 
> python code below. When I run this code on el6 s1 dominates s0 however 
> when I run the same code on el7 s1 does not dominate s0. On both systems 
> the file read dominance check works as expected. Can anyone help me 
> understand why the context contains check does not work the same on both 
> systems?

That would depend entirely on how the constraint is written in the 
policy.  I assume this is with the -mls policy on both?  seinfo 
--constrain | grep -C1 context would show you the constraint in the 
kernel policy.

Looks like refpolicy defines it as:
mlsconstrain context contains
         (( h1 dom h2 ) and ( l1 domby l2));

The 2nd part of the constraint was introduced by:
commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc
Author: Harry Ciao <qingtao.cao@windriver.com>
Date:   Tue Feb 15 10:16:32 2011 +0800

     l1 domby l2 for contains MLS constraint

     As identified by Stephan Smalley, the current MLS constraint for the
     contains permission of the context class should consider the current
     level of a user along with the clearance level so that mls_systemlow
     is no longer considered contained in mls_systemhigh.

     Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>

This was to prevent a user from logging in at a level below their 
authorized range, in the unusual scenario where the user's low level was 
not s0/systemlow.

> 
> Ted
> 
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> import selinux
> 
> SECCLASS_CONTEXT = selinux.string_to_security_class("context")
> CONTEXT__CONTAINS = selinux.string_to_av_perm(SECCLASS_CONTEXT, "contains")
> SECCLASS_FILE = selinux.string_to_security_class("file")
> FILE__READ = selinux.string_to_av_perm(SECCLASS_FILE, "read")
> 
> raw_con1 = "user_u:user_r:user_t:s1"
> raw_con2 = "user_u:user_r:user_t:s0"
> 
> avd = selinux.av_decision()
> selinux.avc_reset()
> try:
>      rc = selinux.security_compute_av_raw(raw_con1, raw_con2, 
> SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)
>      if rc < 0:
>          print("selinux.security_compute_av_raw failed for %s %s" % 
> (raw_con1, raw_con2))
>      if (avd.allowed & CONTEXT__CONTAINS) == CONTEXT__CONTAINS:
>          print("%s dominates %s" % (raw_con1, raw_con2))
>      else:
>          print("%s does not dominate %s" % (raw_con1, raw_con2))
> except OSError, ex:
>      print "exception calling selinux.security_compute_av_raw", ex
> 
> avd = selinux.av_decision()
> selinux.avc_reset()
> try:
>      rc = selinux.security_compute_av_raw(raw_con1, raw_con2, 
> SECCLASS_FILE, FILE__READ, avd)
>      if rc < 0:
>          print("selinux.security_compute_av_raw failed for %s %s" % 
> (raw_con1, raw_con2))
>      if (avd.allowed & FILE__READ) == FILE__READ:
>          print("%s dominates %s" % (raw_con1, raw_con2))
>      else:
>          print("%s does not dominate %s" % (raw_con1, raw_con2))
> 
> except OSError:
>      print "exception calling selinux.security_compute_av_raw", ex
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
