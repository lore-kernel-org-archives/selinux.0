Message-ID: <4175142A.6090807@redhat.com>
Date: Tue, 19 Oct 2004 09:18:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: More patches for policy.
References: <41741D58.2050700@redhat.com> <20041018210443.GB2536@jmh.mhn.de>
In-Reply-To: <20041018210443.GB2536@jmh.mhn.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Bleher wrote:

>* Daniel J Walsh <dwalsh@redhat.com> [2004-10-18 22:53]:
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/innd.fc policy-1.17.32/file_contexts/program/innd.fc
>>--- nsapolicy/file_contexts/program/innd.fc	2004-06-16 13:33:37.000000000 -0400
>>+++ policy-1.17.32/file_contexts/program/innd.fc	2004-10-18 13:37:22.000000000 -0400
>>@@ -8,8 +8,41 @@
>> /var/lib/news(/.*)?		system_u:object_r:innd_var_lib_t
>> /var/run/news(/.*)?	 	system_u:object_r:innd_var_run_t
>> /usr/sbin/in.nnrpd	--	system_u:object_r:innd_exec_t
>>-/usr/lib(64)?/news/bin/.*	--	system_u:object_r:innd_exec_t
>> /usr/bin/inews		--	system_u:object_r:innd_exec_t
>> /usr/bin/rnews		--	system_u:object_r:innd_exec_t
>>-/usr/lib/news/bin/innd 	--	system_u:object_r:innd_exec_t
>>-
>>+/usr/lib(64)?/news/bin(/.*)?		system_u:object_r:bin_t
>>+/usr/lib(64)?/news/bin/innd 	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/actsync	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/archive	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/batcher	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/buffchan	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/convdate	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/ctlinnd	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/cvtbatch	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/expire	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/expireover	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/fastrm	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/filechan	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/getlist	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/grephistory	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/inews	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/innconfval	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/innd	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/inndf	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/inndstart	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/innfeed	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/innxbatch	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/innxmit	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/makedbz	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/makehistory	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/newsrequeue	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/nnrpd	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/nntpget	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/ovdb_recover	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/overchan	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/prunehistory	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/rnews	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/shlock	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/shrinkfile	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/sm	--	system_u:object_r:innd_exec_t
>>+/usr/lib(64)?/news/bin/startinnfeed	--	system_u:object_r:innd_exec_t
>>    
>>
>
>This seems a little bit excessive. How many other files are there? Might
>make sense to list only the files which should be labeled bin_t.
>
>Additionally, are all these programs entrypoints to innd or are they
>only called internally? I know nothing about innd, so please excuse my
>ignorance. If these are all internal helper programs, they shouldn't be
>labeled innd_exec_t, bin_t or innd_helper_exec_t would be better.
>
>Thomas
>
>  
>
I also no nothing about it, this is just an effort to stop labeling 
shell scripts as innd_exec_t.  I was hoping someone could further refine 
the policy.  innd was requesting lots of privs because scripts were 
labelled as innd.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
