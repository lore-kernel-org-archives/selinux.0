Message-ID: <511E45F6.4030300@tycho.nsa.gov>
Date: Fri, 15 Feb 2013 09:28:06 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Luis Ressel <aranea@aixah.de>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux enforcing
 mode
References: <20130214222502.2f7d657c@gentp.lnet> <511E38E7.4040609@tycho.nsa.gov> <20130215150649.22c20d5c@gentp.lnet>
In-Reply-To: <20130215150649.22c20d5c@gentp.lnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/15/2013 09:06 AM, Luis Ressel wrote:
> On Fri, 15 Feb 2013 08:32:23 -0500
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>> Try stripping dontaudit rules from your policy and re-testing.
>> semodule -DB
>> <re-test>
>> semodule -B
>
> Thanks for your tip, but I already did that before contacting this ML.
> There are no denial messages during that time of boot, and all denials
> which happen earlier or later don't look related.
>
> Some minutes ago, I managed to find the exact calls to
> avc_has_perm_noaudit which are involved here by excessive use of printk,
> but I haven't figured out yet how to interpret its arguments.

So, just to be clear, you are saying that avc_has_perm_noaudit() is 
getting a denial (i.e. denied != 0) but you are never getting an avc 
denied message even with no dontaudit rules?

You could call slow_avc_audit() directly to display the arguments in a 
meaningful format.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
