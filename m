Subject: Re: MLS issue
To: Kashif ali <kashif.ali.9498@gmail.com>, Simon Sekidde <ssekidde@redhat.com>
References: <CAFC8oacRU0fR=0Ynib0Bsdq21MGCgjwttAMXNrmjf9y9pVWE2A@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3fb854c4-fdf4-2bbf-8956-c713a17760b8@tycho.nsa.gov>
Date: Wed, 26 Oct 2016 10:17:27 -0400
MIME-Version: 1.0
In-Reply-To: <CAFC8oacRU0fR=0Ynib0Bsdq21MGCgjwttAMXNrmjf9y9pVWE2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/26/2016 03:47 AM, Kashif ali wrote:
> Hi 
>    Hope you're fine i know your busy but i need your little time if you
> can manage that will be great for me.
> i'm facing an issue in MLS Policy of Selinux when i relabel the system
> and reboot it it won't allow me to login(i'm signing in my machine ) i
> used these commands
>  * set the selinux to enforcing
>  * touch ./autorelabel for relabeling the system  
>  * and then reboot the system and it won't allow me to login
> 
> Kindly help in this problem because i'm stuck in it for a while and it
> will be very greatful. Thanks

Generally it is a good idea to first bring up the system in permissive
when switching to MLS, and check that there are no residual denials or
other SELinux errors that need to be addressed before putting it into
enforcing mode.  We would need to see the actual error messages to help
debug further.  And it would help to specify your specific distribution
and version.
