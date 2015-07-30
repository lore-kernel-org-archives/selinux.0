Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6U9GFJX024063
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 05:16:16 -0400
Subject: Re: [PATCH] policycoreutils/semanage: improve compatibility with
 Python 3 in seobject.py
To: Jason Zaman <jason@perfinion.com>
References: <1438241115-9039-1-git-send-email-msrb@redhat.com>
 <1438241115-9039-2-git-send-email-msrb@redhat.com>
 <20150730080404.GA1792@meriadoc.perfinion.com>
From: Michal Srb <msrb@redhat.com>
Message-ID: <55B9EB5A.5090804@redhat.com>
Date: Thu, 30 Jul 2015 11:16:10 +0200
MIME-Version: 1.0
In-Reply-To: <20150730080404.GA1792@meriadoc.perfinion.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 07/30/2015 10:04 AM, Jason Zaman wrote:
> On Thu, Jul 30, 2015 at 09:25:15AM +0200, Michal Srb wrote:
>> - replace print statement with print function
>> - use reserved word `as` in try-except
>> - work with dict.keys() in a way compatible with both Python 2 and 3
>>
>> Signed-off-by: Michal Srb <msrb@redhat.com>
>> ---
>>   policycoreutils/semanage/seobject.py | 118 +++++++++++++++++------------------
>>   1 file changed, 59 insertions(+), 59 deletions(-)
>>
>> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
>> index d29dba5..edd4c83 100644
>> --- a/policycoreutils/semanage/seobject.py
>> +++ b/policycoreutils/semanage/seobject.py
>> @@ -716,7 +716,7 @@ class loginRecords(semanageRecords):
>>       def customized(self):
>>           l = []
>>           ddict = self.get_all(True)
>> -        keys = ddict.keys()
>> +        keys = list(ddict.keys())
>>           keys.sort()
>>           for k in keys:
>>               l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
> Isnt it better to do keys = sorted(ddict.keys()) here instead? then the
> explicit call to list() isnt required which would hurt on python3.

You're right. sorted() looks better. I will modify the patch and send it 
again.

Michal

>
> -- Jason
