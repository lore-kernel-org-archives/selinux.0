Subject: Re: [PATCH 3/3] policycoreutils: setfiles - Modify to use
 selinux_restorecon
To: Richard Haines <richard_c_haines@btinternet.com>
References: <1462893866-9614-1-git-send-email-richard_c_haines@btinternet.com>
 <2687adaa-046c-9ff3-d5f5-b039aa2253c6@tycho.nsa.gov>
 <648764394.3667642.1464699692622.JavaMail.yahoo@mail.yahoo.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <02171ee7-292c-5b04-0834-67e7c1b51003@tycho.nsa.gov>
Date: Tue, 31 May 2016 11:06:45 -0400
MIME-Version: 1.0
In-Reply-To: <648764394.3667642.1464699692622.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/31/2016 09:01 AM, Richard Haines wrote:
> 
> 
> 
> 
> 
>> On Thursday, 19 May 2016, 19:24, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> On 05/10/2016 11:24 AM, Richard Haines wrote:
>>>  Modify setfiles and restorecon to make use of the libselinux
>>>  selinux_restorecon* set of functions.
>>>
>>>  The output from these commands should be much the same as before
>>>  with some minor wording changes, the only exceptions being:
>>>  1) The -p option does not output the percentage, just * for every
>>>  1000 files (but does state approx file count if mass relabel
>>>  and verbose).
>>
>> Seems like it might be a regression for usability on e.g. an autorelabel
>> at boot.
> 
> The main reason I did not implement this is that I would either need to
> pass over the approx amount of files to selinux_restorecon() or implement
> the exclude_non_seclabel_mounts() function in selinux_restorecon().
> I guess if this is required then adding exclude_non_seclabel_mounts(),
> add_exclude() and remove_exclude() to selinux_restorecon may be the best
> option as that resolves one of your queries on [PATCH 2/3]. Any views on
> the best way forward.

I guess the latter IIUC; it makes sense for selinux_restorecon() to
compute the estimated total number of files internally for use in the
progress output.
