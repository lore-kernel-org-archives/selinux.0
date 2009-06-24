Subject: Re: [PATCH -v2] selinux: clean up avc node cache when disabling
 selinux
From: Eric Paris <eparis@redhat.com>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org
In-Reply-To: <1245880685.27271.2.camel@Ares>
References: <1245880456.26725.5.camel@Ares>  <1245880685.27271.2.camel@Ares>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 18:08:18 -0400
Message-Id: <1245881298.11046.31.camel@dhcp235-23.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-06-24 at 17:58 -0400, Thomas Liu wrote:
> Added a call to free the avc_node_cache when inside selinux_disable because
> it should not waste resources allocated during avc_init if SELinux is disabled
> and the cache will never be used.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>

Acked-by: Eric Paris <eparis@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
