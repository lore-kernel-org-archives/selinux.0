Subject: Re: fail to get seandroid code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ken.masumitsu@accenture.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4FB623F8.2060403@accenture.com>
References: <4FB623F8.2060403@accenture.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 May 2012 07:07:20 -0400
Message-ID: <1337339240.24439.2.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-05-18 at 10:30 +0000, ken.masumitsu@accenture.com wrote:
> Hi,
> 
> When I ran "repo sync" to install seandroid in reference to
> http://selinuxproject.org/page/SEAndroid, I got an error like
> ---------------------------------------------------
> Fetching projects: 10% (24/239) fatal:
> http://selinuxproject.org/~seandroid/git/device/samsung/tuna/info/refs
> not found: did you run git update-server-info on the server?
> ---------------------------------------------------
> 
> Though I checked the URL
> (http://selinuxproject.org/~seandroid/git/device/samsung/tuna/info/refs)
> by a browser, there is not such a directory.
> 
> Why the directory does not exist on the server?

Thanks for the report - this should now be fixed.  When we added the
tuna project, we didn't set up the http-based access for it.

BTW, it has been recently pointed out that the tuna/sepolicy.* files
actually need to be copied over to maguro/ or toro/ in order to be
picked up during the build.  We'll fix that, but in the interim, you can
do that manually.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
