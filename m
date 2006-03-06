Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k26HdFQh004591
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 12:39:15 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k26HdDuY008244
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 17:39:13 GMT
Message-ID: <440C73BA.4050503@redhat.com>
Date: Mon, 06 Mar 2006 12:39:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jvdias@redhat.com, Ivan Gyurdiev <ivg2@cornell.edu>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: named SELinux policy
References: <200603061121.49118.jvdias@redhat.com>
In-Reply-To: <200603061121.49118.jvdias@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jason Vas Dias wrote:
> Hi Dan -
>
> Ivan raised a good point about the named SELinux policy:
> On Saturday 04 March 2006 14:49, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
>   
>>  files_read_etc_files(named_t) allows named to read all files marked 
>>  etc_t. Those are usually configuration files, shouldn't be any secrets 
>>  there.... What if it turns out there is a secret file mislabeled by 
>>  mistake? Why is named interested in configuration of other programs anyway?
>>     
> On Saturday 04 March 2006 15:14, Jason Vas Dias <jvdias@redhat.com> wrote:
>   
>>  This is because named.conf can 'include "...";' other files, which are in $ROOTDIR/etc
>>  and not labelled as named_conf_t by default - unless in the chroot, where 
>>  /var/named/chroot/etc/* is labelled as named_conf_t. I think probably this should be
>>  changed to label  /etc/named.* or /etc/bind/* as named_conf_t and disallow named etc_t 
>>  read privilege. But this is mitigated by the fact that named runs as the 'named:named' user, 
>>  and most /etc/* files should be -rw------- .
>>     
>
> The named process does not read any /etc/ files that are not named_conf_t . 
> The initscript, which has context initrc_exec_t, may need to read /etc/ files 
> or invoke other programs which do so. 
> The rndc process should ONLY need to read $ROOTDIR/etc/rndc.* files, which
> should all have context named_conf_t . (Currently, $ROOTDIR/etc/rndc.* only
> gets labelled as named_conf_t if $ROOTDIR is /var/named - this seems odd).
>
> Please can we remove these lines from the bind.te devel policy:
>
> files_read_etc_files(named_t)
> files_read_etc_runtime_files(named_t)
> files_read_etc_files(ndc_t)
>
> And replace this line in bind.fc :
> /etc/named\.conf  -- gen_context(system_u:object_r:named_conf_t,s0)
> with
> /etc/{named,rndc}.*      gen_context(system_u:object_r:named_conf_t,s0)
>
> With the next version of bind, I'm going to be replacing the named.conf
> Provide-d by caching-nameserver with :
>  $ROOTDIR/etc/named.caching-nameserver.conf , which will include:
>  $ROOTDIR/etc/named.rfc1912.zones.conf
>
> And I think we need a better way of labelling named configuration files
> as named_conf_t rather than just letting named read etc_t* .
>
> Please let me know your opinion on the above and whether these changes
> can go in to FC-5.
>
> Thanks & Regards,
> Jason
>   
I am not a big fan of labeling files in /etc as something other than 
etc_t.  If these files get created by another tool (sed, emacs, ed, cp, 
system-config-bind ...) that does not maintain security context all of a 
sudden named will mysteriously stop working.  Named starts blowing up, 
User blames SELinux, turns SELinux off.

File context that differs from parent directory is especially hard to 
maintain and can give the impression that SELinux is difficult.  We can 
not predict which tools a user will use to maintain the named.conf file 
so leaving it etc_t is better in my opinion.  If you want to prevent 
secret data then you should not store a file in /etc with default 
context (etc_t, etc_runtime_t).  (You probably should not store the file 
there in the  first place.)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
