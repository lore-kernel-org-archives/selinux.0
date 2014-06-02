Message-ID: <538C7A0D.8010607@tycho.nsa.gov>
Date: Mon, 02 Jun 2014 09:20:13 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: How does matchpathcon/setfiles work?
References: <538B4487.8050807@gmail.com>
 <CAPzO=NycsK+-5EDgtJh8nFx7WjFT0isYyxgrKxqqtrq3SdRgkg@mail.gmail.com>
 <538C4AA1.3030106@gmail.com>
In-Reply-To: <538C4AA1.3030106@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/02/2014 05:57 AM, dE wrote:
> On 06/02/14 12:12, Sven Vermeulen wrote:
>>
>> Policies do contain paths. They contain path expressions to be more
>> precise.
>>
>> During policy load, the path expressions together with the target
>> contexts are extracted and placed in
>> /etc/selinux/mcs/contexts/files/file_contexts, which is where tools
>> like matchpathcon get their information from.
>>
>> Wkr,
>>   Sven Vermeulen
>>
>> On Jun 1, 2014 5:48 PM, "dE" <de.techno@gmail.com
>> <mailto:de.techno@gmail.com>> wrote:
>>
>>     As we know, policies don't contain paths. So the working of
>>     matchpathcon/setfiles must be based on common sense.
>>
>>     It looks like it knows certain special folders and it's
>>     appropriate security context, for e.g. home folder contents should
>>     have files with user_home_t and suggests the correct SELinux user
>>     for the files/directories based on which user's home folder is it.
>>
>>     Other directories/files should have the same security context as
>>     the parent directory, like with /opt.
>>
>>     Is this correct?
>>
> 
> Do the paths have any other purpose other than defining the default
> security context?

No, and they are not part of the kernel policy, only used by userspace
programs like setfiles, udev, package managers like rpm/dpkg, etc.
