Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9KCwpmK007845
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 08:58:51 -0400
Received: from mailgate1.arcor-ip.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9KCvOYY001567
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 12:57:25 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id A26FA1B5198
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 14:58:50 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 4C7AD5663
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 12:58:50 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17951-08 for <selinux@tycho.nsa.gov>;
 Fri, 20 Oct 2006 14:58:48 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id CA2175648
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 14:58:48 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: Policy tests failed
Date: Fri, 20 Oct 2006 14:58:42 +0200
References: <200610191700.20138.Daniel.Gil-Mayol@brunel.de> <1161282600.14632.199.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161282600.14632.199.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200610201458.42923.Daniel.Gil-Mayol@brunel.de>
Content-Type: multipart/alternative;
  boundary="Boundary-00=_CgMOF5cYEcZqOac"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_CgMOF5cYEcZqOac
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="utf-8"

> On Thu, 2006-10-19 at 17:00 +0200, Daniel Gil Mayol wrote:
> > I am writting a policy over a RHEL4 customized kernel. I want to extend
> > the current targeted policy (there are some new services to define a
> > policy).
>
> Can you identify the particular policy version that you are using as
> your baseline?

The version number of the SELinux policy language that I am using to create 
the binary policy is 18 (policy.18).

> > I want to test the policy, that is, the services should not have access
> > (read/write/execute) to data that are not allowed.
> > So I have written a script "exectest.py" labelled with a security context
> > "system_u:object_r:XXX_t" where "type XXX_t, file_type;".
> >
> From the above description, I am not clear as to how you are using the
> type of the script.  Do you want to transition into a different domain
> upon executing the script?  Or not?

I want that the script makes a transition into a different domain. For this 
reason now I have the script relabel with the type "initrc_exec_t" and seems 
that after execute "runcon -t crond_t" it makes a transition to the crond_t 
domain.

> > Lets say that we are testing the service "crond", so I execute
> > "exectest.py crond". The first that do this script is execute an "id" and
> > become the next:
> >
> > uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6
> > (disk),10(wheel) context=root:system_r:unconfined_t
>
> So the script starts off in the same context as the caller (unconfined
> in this instance).  What do you mean by "become the next"?  

I mean I see the next message after start the script and "id" is executed 
(this is the problem of the literally translations :p  )

> Does it execute the real crond?  Or run some test script using runcon -t
> crond_t to put it into the crond_t domain?  Can you just post the script
> itself? 

The script don't execute crond, only prove that being in the crond_t domain 
can not access to data of another domain (for example httpd_exec_t).

> > Then the script try to read, write and execute files out of "crond_t"
> > domain, that is, files labelled with types that I haven't allowed (for
> > example bin_t, httpd_t). And the result is that it can.
>
> Not clear what "out of the "crond_t" domain" means above - how did it
> get into the crond_t domain?  How did you check that it actually ran in
> that domain?

Now the script get into anacron_t (now I am testing with anacron) domain using 
the command "runcon -t anacron_t". The script shows now after execute the 
command "id" the next:

uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6
(disk),10(wheel) context=root:system_r:anacron_t

> I'm also not sure how crond_t is defined in your policy; in targeted
> policy, crond is unconfined.  In strict policy, it is confined, and
> transitions to different domains depending on the job (e.g.
> system_crond_t for system jobs, user_crond_t for ordinary user jobs,
> sysadm_crond_t for root user crontab).  Naturally, system cron jobs
> often require different permissions than user ones.

Here goes part of the script to test that a domain (ex. anacron) can only 
execute files that is allowed to (ex. anacron_exec_t):

###########     file: exectest.py     #############
   def testBin():
       result=True
       try:
           os.system(filedir+filename+" >/dev/null")
       except:
           result=False
 
      return result
##################################

Where 
   - filename: are all executable files. Derived from a "for" loop
   - filedir is a constant value with the directory where to find these files.

About execute runcon I've read the next mail from 
http://www.redhat.com/archives/fedora-selinux-list/2004-October/msg00105.html
------------------------------------------------------------------------------------------
I don't have any test scripts but i think rolling back the packages to one 
with a known vulerability would work, but since one goal of a hacker is to 
get a root shell, you could use runcon with a shell script to simulate what 
would happen if a hacker was successfull.
runcon -t httpd_t /bin/sh
Of course I can only get this to work in permissive mode. Setting it to 
enforcing kills the shell since it can not access the tty.
Also get an error "execvp: Permission denied" in enforcing.
-------------------------------------------------------------------------------------------
I thought I must run my policy test script in a enforce mode but I get the 
permission denied error (like the mail says). So, I have to run the script in 
permissive mode and look the 'audit denies' that appears 
in /var/log/messages?

> > I have tried also to write in the policy for example "neverallow crond_t
> > bin_t : file { read write execute };" but still can access to these data.
>
> neverallow statements are assertions on the policy that are checked when
> the policy is compiled.  So if you were able to successfully rebuild the
> policy after adding such an assertion, then the policy should not
> contain any allow rules granting such access.  But it isn't clear to me
> that your script is ever executing in crond_t.
>
> > When I execute this script, which domain it has?
>
> If you haven't defined a domain transition in your policy on the type
> assigned to the script, then it stays in the caller's domain (in this
> case, unconfined_t).  Unless the caller uses runcon or similar to
> specifically run the script in a specified domain.
>
> > Can it be that it works in the unconfined domain and it has access to
> > everything?
> >
> >From the output you posted, yes.  The id output showed it being
>
> unconfined_t.
--Boundary-00=_CgMOF5cYEcZqOac
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
  charset="utf-8"

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:10pt;font-family:Sans Serif">
<p><span style="color:#008000">&gt; On Thu, 2006-10-19 at 17:00 +0200, Daniel Gil Mayol wrote:</span></p>
<p><span style="color:#007000">&gt; &gt; I am writting a policy over a RHEL4 customized kernel. I want to extend</span></p>
<p><span style="color:#007000">&gt; &gt; the current targeted policy (there are some new services to define a</span></p>
<p><span style="color:#007000">&gt; &gt; policy).</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#008000">&gt; Can you identify the particular policy version that you are using as</span></p>
<p><span style="color:#008000">&gt; your baseline?</span></p>
<p></p>
<p>The version number of the SELinux policy language that I am using to create the binary policy is 18 (policy.18).</p>
<p></p>
<p><span style="color:#007000">&gt; &gt; I want to test the policy, that is, the services should not have access</span></p>
<p><span style="color:#007000">&gt; &gt; (read/write/execute) to data that are not allowed.</span></p>
<p><span style="color:#007000">&gt; &gt; So I have written a script &quot;exectest.py&quot; labelled with a security context</span></p>
<p><span style="color:#007000">&gt; &gt; &quot;system_u:object_r:XXX_t&quot; where &quot;type XXX_t, file_type;&quot;.</span></p>
<p><span style="color:#007000">&gt; &gt;</span></p>
<p><span style="color:#008000">&gt; From the above description, I am not clear as to how you are using the</span></p>
<p><span style="color:#008000">&gt; type of the script.  Do you want to transition into a different domain</span></p>
<p><span style="color:#008000">&gt; upon executing the script?  Or not?</span></p>
<p></p>
<p>I want that the script makes a transition into a different domain. For this reason now I have the script relabel with the type &quot;initrc_exec_t&quot; and seems that after execute &quot;runcon -t crond_t&quot; it makes a transition to the crond_t domain.</p>
<p></p>
<p><span style="color:#007000">&gt; &gt; Lets say that we are testing the service &quot;crond&quot;, so I execute</span></p>
<p><span style="color:#007000">&gt; &gt; &quot;exectest.py crond&quot;. The first that do this script is execute an &quot;id&quot; and</span></p>
<p><span style="color:#007000">&gt; &gt; become the next:</span></p>
<p><span style="color:#007000">&gt; &gt;</span></p>
<p><span style="color:#007000">&gt; &gt; uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6</span></p>
<p><span style="color:#007000">&gt; &gt; (disk),10(wheel) context=root:system_r:unconfined_t</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#008000">&gt; So the script starts off in the same context as the caller (unconfined</span></p>
<p><span style="color:#008000">&gt; in this instance).  What do you mean by &quot;become the next&quot;?  </span></p>
<p></p>
<p>I mean I see the next message after start the script and &quot;id&quot; is executed (this is the problem of the literally translations :p  )</p>
<p></p>
<p><span style="color:#008000">&gt; Does it execute the real crond?  Or run some test script using runcon -t</span></p>
<p><span style="color:#008000">&gt; crond_t to put it into the crond_t domain?  Can you just post the script</span></p>
<p><span style="color:#008000">&gt; itself? </span></p>
<p></p>
<p>The script don't execute crond, only prove that being in the crond_t domain can not access to data of another domain (for example httpd_exec_t).</p>
<p></p>
<p><span style="color:#007000">&gt; &gt; Then the script try to read, write and execute files out of &quot;crond_t&quot;</span></p>
<p><span style="color:#007000">&gt; &gt; domain, that is, files labelled with types that I haven't allowed (for</span></p>
<p><span style="color:#007000">&gt; &gt; example bin_t, httpd_t). And the result is that it can.</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#008000">&gt; Not clear what &quot;out of the &quot;crond_t&quot; domain&quot; means above - how did it</span></p>
<p><span style="color:#008000">&gt; get into the crond_t domain?  How did you check that it actually ran in</span></p>
<p><span style="color:#008000">&gt; that domain?</span></p>
<p></p>
<p>Now the script get into anacron_t (now I am testing with anacron) domain using the command &quot;runcon -t anacron_t&quot;. The script shows now after execute the command &quot;id&quot; the next:</p>
<p></p>
<p>uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel) context=root:system_r:anacron_t</p>
<p></p>
<p><span style="color:#008000">&gt; I'm also not sure how crond_t is defined in your policy; in targeted</span></p>
<p><span style="color:#008000">&gt; policy, crond is unconfined.  In strict policy, it is confined, and</span></p>
<p><span style="color:#008000">&gt; transitions to different domains depending on the job (e.g.</span></p>
<p><span style="color:#008000">&gt; system_crond_t for system jobs, user_crond_t for ordinary user jobs,</span></p>
<p><span style="color:#008000">&gt; sysadm_crond_t for root user crontab).  Naturally, system cron jobs</span></p>
<p><span style="color:#008000">&gt; often require different permissions than user ones.</span></p>
<p></p>
<p>Here goes part of the script to test that a domain (ex. anacron) can only execute files that is allowed to (ex. anacron_exec_t):</p>
<p></p>
<p>###########     file: exectest.py     #############</p>
<p>   def testBin():</p>
<p>       result=True</p>
<p>       try:</p>
<p>           os.system(filedir+filename+&quot; &gt;/dev/null&quot;)</p>
<p>       except:</p>
<p>           result=False</p>
<p> </p>
<p>      return result</p>
<p>##################################</p>
<p></p>
<p>Where </p>
<p>   - filename: are all executable files. Derived from a &quot;for&quot; loop</p>
<p>   - filedir is a constant value with the directory where to find these files.</p>
<p></p>
<p>About execute runcon I've read the next mail from http://www.redhat.com/archives/fedora-selinux-list/2004-October/msg00105.html</p>
<ul type="disc"><li>------------------------------------------------------------------------------------------</li></ul>
<p>I don't have any test scripts but i think rolling back the packages to one with a known vulerability would work, but since one goal of a hacker is to get a root shell, you could use runcon with a shell script to simulate what would happen if a hacker was successfull.</p>
<p>runcon -t httpd_t /bin/sh</p>
<p>Of course I can only get this to work in permissive mode. Setting it to enforcing kills the shell since it can not access the tty.</p>
<p>Also get an error &quot;execvp: Permission denied&quot; in enforcing.</p>
<ul type="disc"><li>-------------------------------------------------------------------------------------------</li></ul>
<p>I thought I must run my policy test script in a enforce mode but I get the permission denied error (like the mail says). So, I have to run the script in permissive mode and look the 'audit denies' that appears in /var/log/messages?</p>
<p></p>
<p><span style="color:#007000">&gt; &gt; I have tried also to write in the policy for example &quot;neverallow crond_t</span></p>
<p><span style="color:#007000">&gt; &gt; bin_t : file { read write execute };&quot; but still can access to these data.</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#008000">&gt; neverallow statements are assertions on the policy that are checked when</span></p>
<p><span style="color:#008000">&gt; the policy is compiled.  So if you were able to successfully rebuild the</span></p>
<p><span style="color:#008000">&gt; policy after adding such an assertion, then the policy should not</span></p>
<p><span style="color:#008000">&gt; contain any allow rules granting such access.  But it isn't clear to me</span></p>
<p><span style="color:#008000">&gt; that your script is ever executing in crond_t.</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#007000">&gt; &gt; When I execute this script, which domain it has?</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#008000">&gt; If you haven't defined a domain transition in your policy on the type</span></p>
<p><span style="color:#008000">&gt; assigned to the script, then it stays in the caller's domain (in this</span></p>
<p><span style="color:#008000">&gt; case, unconfined_t).  Unless the caller uses runcon or similar to</span></p>
<p><span style="color:#008000">&gt; specifically run the script in a specified domain.</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#007000">&gt; &gt; Can it be that it works in the unconfined domain and it has access to</span></p>
<p><span style="color:#007000">&gt; &gt; everything?</span></p>
<p><span style="color:#007000">&gt; &gt;</span></p>
<p><span style="color:#007000">&gt; &gt;From the output you posted, yes.  The id output showed it being</span></p>
<p><span style="color:#008000">&gt;</span></p>
<p><span style="color:#008000">&gt; unconfined_t.</span></p>
</body></html>
--Boundary-00=_CgMOF5cYEcZqOac--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
