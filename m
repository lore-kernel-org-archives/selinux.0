Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7CKQNqh024200
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 16:26:24 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7CKRQdb006362
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 20:27:26 GMT
Message-ID: <4A83256B.3090806@redhat.com>
Date: Wed, 12 Aug 2009 16:26:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to semanage
References: <C6A89AF9.A9A88%csellers@tresys.com>
In-Reply-To: <C6A89AF9.A9A88%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/12/2009 04:14 PM, Chad Sellers wrote:
> On 7/17/09 6:10 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> Ok lets try the patch again.
>>
>> Added equal patch (spelled correctly.)
>> Beginning to add modules support to consolidate on one management command.
>> Eventually replace semodule/setsebool with semanage command.
>> Some white space fixing in seobject.py
> 
> I'm looking at this patch now. There are a couple of changes that I believe
> are not part of the rest, but I wonder if you could verify this (and maybe
> tell me why they're here).
> 
>> diff --git a/policycoreutils/semanage/seobject.py
>> b/policycoreutils/semanage/seobject.py
>> index 94bdf7f..5b94a0f 100644
>> --- a/policycoreutils/semanage/seobject.py
>> +++ b/policycoreutils/semanage/seobject.py
>> @@ -21,7 +21,7 @@
>>  #
>>  #  
>>  
>> -import pwd, grp, string, selinux, tempfile, os, re, sys
>> +import pwd, grp, string, selinux, tempfile, os, re, sys, stat
>>  from semanage import *;
>>  PROGNAME = "policycoreutils"
>>  import sepolgen.module as module
>> @@ -273,6 +273,7 @@ class setransRecords:
>>                 (fd, newfilename) = tempfile.mkstemp('', self.filename)
>>                 os.write(fd, self.out())
>>                 os.close(fd)
>> +               os.chmod(newfilename, os.stat(self.filename)[stat.ST_MODE])
>>                 os.rename(newfilename, self.filename)
>>                  os.system("/sbin/service mcstrans reload > /dev/null")
>>  
> I'm guessing there was some problem with the permissions on setrans files?
Well the tool was not maintainng the permissions,  But I believe we should just remove all handling of setrans records, since this stuff will not work with the latest code.  semanage should no longer manage the translatetions.
> 
>> @@ -983,7 +1027,7 @@ class portRecords(semanageRecords):
>>                         proto_str = semanage_port_get_proto_str(proto)
>>                         low = semanage_port_get_low(port)
>>                         high = semanage_port_get_high(port)
>> -                       ddict[(low, high)] = (ctype, proto_str, level)
>> +                       ddict[(low, high, proto_str)] = (ctype, level)
>>                 return ddict
>>  
>>         def get_all_by_type(self, locallist = 0):
> 
> Was this just plain wrong before? I'm not familiar with this. Was there not
> a user before (and presumably there is one now)?
> 
> Everything else seems to fall into one of your 3 categories above.
> 
> Thanks,
> Chad
> 

Yes this was a bug.  

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
