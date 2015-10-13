Subject: Re: [RFC PATCH V3] libselinux: Add selabel_digest function
To: Richard Haines <richard_c_haines@btinternet.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <56181972.8000901@tycho.nsa.gov>
 <1884047573.3637566.1444652781647.JavaMail.yahoo@mail.yahoo.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <561D74CD.20109@tycho.nsa.gov>
Date: Tue, 13 Oct 2015 17:17:01 -0400
MIME-Version: 1.0
In-Reply-To: <1884047573.3637566.1444652781647.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/12/2015 08:26 AM, Richard Haines wrote:
>
>
>
>
>
>> On Friday, 9 October 2015, 20:46, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 09/30/2015 11:29 AM, Richard Haines wrote:
>>>   selabel_digest(3) if enabled by the SELABEL_OPT_DIGEST option during
>>>   selabel_open(3) will return an SHA1 digest of the spec files, plus
>>>   a list of the specfiles used to calculate the digest. There is a
>>>   test utility supplied that will demonstrate the functionality.
>>>
>>>   The use case for selabel_digest(3) is to implement an selinux_restorecon
>>>   function based on the Android version that writes a hash of the
>>>   file_contexts files to an extended attribute to enhance performance
>>>   (see external/libselinux/src/android.c selinux_android_restorecon()).
>>>
>>>   Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>
>> Seems sane to me.  Is there a reason it is still an RFC?
>
>>
>
> No - Would you like it submitted without the RFC

No need, applied.
