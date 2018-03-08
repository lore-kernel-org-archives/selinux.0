Reply-To: dwalsh@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>, Zvonko Kosic <zkosic@redhat.com>,
 selinux@tycho.nsa.gov
References: <CAFrfeQ5LmB6bCTT7rP8Afbmvfy8M0MpZwzunfixWA0t_wW4oBQ@mail.gmail.com>
 <35c8119b-046b-ce96-10cc-c7e17ce7d943@tycho.nsa.gov>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <b1e332be-ace1-0d11-8541-53549d0e4499@redhat.com>
Date: Thu, 8 Mar 2018 13:23:33 +0000
MIME-Version: 1.0
In-Reply-To: <35c8119b-046b-ce96-10cc-c7e17ce7d943@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: SELinux Namespace on bind mounted files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/08/2018 01:20 PM, Stephen Smalley wrote:
> On 03/08/2018 05:55 AM, Zvonko Kosic wrote:
>> I've seen the presentation by James Morrison about  namespacing SELinux and I have a question regarding a special case we have in our environment.
>>
>> We have third party prestart runtime hooks for docker which bind mount
>> files from the host into the container image, which have the wrong label.
>>
>> To change the SELinux labels on the host is not an option because
>> it breaks stuff on the host.
>>
>> Wil the SELinux namespacing work on files that are bind mounted?
> I believe the answer is yes, since my patches support per-namespace in-core inode SIDs and James' additional patches support per-namespace on-disk xattrs (so the bind-mounted files can have two distinct labels, one of which will be presented to processes in the root/init namespace and the other to processes within the child namespace).  That said, this is all very much work in progress.
>
>
I am not a big fan of Namespaced SELinux.  I think it complicates things 
and will confuse people.  I would think a better solution would be to 
run your container with a different type so that you could allow access 
t othese file types.

It would be a lot easier to create a type based on container-selinux 
policy and just run your container with it.


podman run -ti --security-opt label=type:mycontianer_t -v /SRC:/DEST IMAGE

Or if  you must

docker run -ti --security-opt label=type:mycontianer_t -v /SRC:/DEST IMAGE
