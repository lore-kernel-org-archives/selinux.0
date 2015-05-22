Message-ID: <555F6047.8030104@tycho.nsa.gov>
Date: Fri, 22 May 2015 12:58:47 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ted Toth <txtoth@gmail.com>
Subject: Re: string_to_av_perm behavior
References: <CAFPpqQHQ5n=4chF3hCbQMQfU6yZ9KgjoVyotGCg6FA1RDdtxiw@mail.gmail.com>	<555F5762.8040601@tycho.nsa.gov>	<555F5802.3090104@tycho.nsa.gov>	<CAFPpqQHahMR9UeCOUsEH=DV1tVy2ZXSMgrOLRNcV78aNsOiXGA@mail.gmail.com>	<CAFPpqQF5OC-M=Lzgx0NORX2go+cifzcsFs1JjABOotRXqmbNVg@mail.gmail.com>	<555F5BDF.7090906@tycho.nsa.gov>
 <CAFPpqQG_Qrre2B-trtUjRFnBAaftF=e5qqjA9tjVDr3aXSw3ew@mail.gmail.com>
In-Reply-To: <CAFPpqQG_Qrre2B-trtUjRFnBAaftF=e5qqjA9tjVDr3aXSw3ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

selinux_check_access() is a pretty simple wrapper around the existing
libselinux interfaces, so you could just grab the code from upstream and
put it into your own library or application.

On 05/22/2015 12:47 PM, Ted Toth wrote:
> :( we currently live in the RHEL6 world.
> 
> On Fri, May 22, 2015 at 11:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/22/2015 12:36 PM, Ted Toth wrote:
>>> What version of libselinux was selinux_check_access added?
>>
>> 2.1.7
>>
>>
> 
> 
