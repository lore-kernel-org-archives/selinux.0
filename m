Message-ID: <542ADCAA.30001@tycho.nsa.gov>
Date: Tue, 30 Sep 2014 12:39:06 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tobias Bengfort <tobias.bengfort@posteo.de>, SELinux@tycho.nsa.gov
Subject: Re: UPower dbus interface unavailable with enforcing SELinux
References: <m08v7l$tpj$1@ger.gmane.org>
In-Reply-To: <m08v7l$tpj$1@ger.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2014 08:33 AM, Tobias Bengfort wrote:
> Hi,
> 
> I am running SELinux on my debian wheezy laptop. I would like to be able
> to suspend in a defined amount of time, say 2h. This is useful e.g. when
> watching a movie and falling asleep.
> 
> Unfortunately, SELinux blocks access to UPower's dbus interface. I guess
> this is because programmatic access to power control is considered
> dangerous.
> 
> My current workaround is to disable SElinux whenever I want to use the
> described feature. This of course is not a desirable solution.
> 
> Is what I am trying to do possible or should I just start reading books
> instead of watching movies?

Please post the actual denials that you see in /var/log/messages or
/var/log/audit/audit.log.
