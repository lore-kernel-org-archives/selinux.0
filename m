Date: Wed, 20 Feb 2002 08:38:31 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Ryan O. Emge" <nesa@mailandnews.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: activity?
In-Reply-To: <50LN0WGPO7AADWYMYiY00000001@50ln0wgpo7aadwy>
Message-ID: <Pine.GSO.4.33.0202200828580.9757-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 19 Feb 2002, Ryan O. Emge wrote:

> That is an extremely valid question as I am questioning whether or not to
> convert my Redhat firewall server to SELinux since I am in one of the NSA's
> 23 centers of academic excellence in their Information Assurance & Security
> program. Any thoughts on this from the inside would be appreciated.

The original questioner hadn't looked closely at the NSA SELinux web site.
If you look at http://www.nsa.gov/selinux/news.html, you'll see that
SELinux is actively being developed and maintained, with relatively
frequent releases, and that it is current with the latest stable version
of the Linux kernel.  So if your only concern is whether SELinux is
actively developed and maintained, that isn't an issue.  Naturally, you
may have other concerns about deploying SELinux in a production
environment.  We track the mainstream Linux kernel rather than a
particular vendor kernel, so you may want to port LSM and SELinux to your
vendor kernel prior to such a deployment.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
