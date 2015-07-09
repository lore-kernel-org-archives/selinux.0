Message-ID: <559E716C.6050000@tycho.nsa.gov>
Date: Thu, 09 Jul 2015 09:04:44 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix typo in semanage args for minimum policy store
References: <1436429776-32450-1-git-send-email-plautrba@redhat.com>
 <20150709100450.GA20638@x250> <559E519D.4060800@redhat.com>
In-Reply-To: <559E519D.4060800@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/09/2015 06:49 AM, Petr Lautrbach wrote:
> Dne 9.7.2015 v 12:04 Dominick Grift napsal(a):
>> On Thu, Jul 09, 2015 at 10:16:16AM +0200, Petr Lautrbach wrote:
>>> ---
>>>  policycoreutils/semanage/semanage | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
>>> index dd63010..dd1010a 100644
>>> --- a/policycoreutils/semanage/semanage
>>> +++ b/policycoreutils/semanage/semanage
>>> @@ -788,7 +788,7 @@ def createCommandParser():
>>>  
>>>  def make_io_args(args):
>>>      # import/export backward compability
>>> -    args_origin = ["-S", "-o", "-i", "targeted", "minumum", "mls"]
>>> +    args_origin = ["-S", "-o", "-i", "targeted", "minimum", "mls"]
>>
>> Hard coding policy models is not very user friendly. Besides the minimum policy model is fedora specific.
>>
> 
> You are right. The patch just fixes the typo which makes it unusable
> even on Fedora.

Agree that we ought to revisit this, but applied the patch to fix the
typo for now.
