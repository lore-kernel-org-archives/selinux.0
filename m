Subject: Re: newrole not working when built with LSPP_PRIV=y
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
References: <560741F0.9090709@debian.org> <560AE811.7070008@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <560CE5E5.9030405@debian.org>
Date: Thu, 1 Oct 2015 09:51:01 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <560AE811.7070008@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



Le 29/09/15 21:35, Stephen Smalley a écrit :
> On 09/26/2015 09:10 PM, Laurent Bigonville wrote:
>> [...]
>>
>> The patch seems to break an other thing, it Fedora the newrole
>> executable is not setuid root, but it is granted a bunch of capabilities
>> explicitly, if I setuid this executable instead of granting these
>> capabilities, I get yet an other error:
>>
>> Sorry, newrole failed to drop capabilities: Operation not permitted
>>
>> So I guess something need to be fixed here.
>
> Yes, the current code just seems to be wrong here.  The setresuid() 
> call will drop all capabilities if newrole is setuid-root and the 
> caller is non-root, so it will end up dropping all capabilities 
> immediately.  Then the attempt to further set the capabilities will 
> fail (as above), as will any subsequent privileged operations.  As 
> currently written, this can only work if not setuid-root and using 
> file-caps.  And in that case, the setresuid() call doesn't make sense.
>
> Dan?

Apparently libcapng has a capng_change_id(3) function that can be used 
to "change the credentials retaining capabilities".

Laurent Bigonville
