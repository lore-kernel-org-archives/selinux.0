Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2GLGhn9019104
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 17:16:43 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2GLGgSj019815
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 21:16:42 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2GLGf56017760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 17:16:42 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p2GLGffP006781
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2011 17:16:41 -0400
Message-ID: <4D8128B9.7040907@redhat.com>
Date: Wed, 16 Mar 2011 17:16:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: I have been asked for a use case that says I want to allow X
 domain to only be able to use eth1.
References: <4D811E7A.6060902@redhat.com>
In-Reply-To: <4D811E7A.6060902@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/16/2011 04:32 PM, Daniel J Walsh wrote:
> For example if you wanted to allow httpd_t to only use eth1, you have a
> problem.  You need to label all of the devices on your system as
> something other then netif_t. And then add a rule like
> 
> semanage interface -a -t public_t eth0
> semanage interface -a -t private_t eth1
> 
> allow { domain -httpd_t } public_t:netif *;
> allow httpd_t private_t:netif *;
> 
> If you wanted all other processes to also use eth0, you would add
> allow domain private_t:netif *;
> 
> Now ignoring the fact that I used domain instead of some attribute to
> indicate all domains that use the network.
> 
> Even if I did the code above, if a new interface showed up later httpd_t
> would be allowed to use it since it can use netif_t, which is the
> default for all interfaces.
> 
> The problem is I can not change the default.
> 
> semanage interface -a -t public_t *
> 
> For example would not work, I don't think.
> 
> I guess I can do something hackly like I am with unlabelednet.pp and
> just put all of the netif rules into a module that I can disable, but I
> wanted to know if anyone has a better way.
> 

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.



I guess for this to work, best I will need to deal with the node instead
of the interface.  As long as there is an IP associated with the node, I
can put a label out like

semanage node -a -t public_node_t 0.0.0.0/0
semanane node -a -t private_node_t 1.2.3.4/32

allow { domain -httpd_t } public_node_t:socket_class_set node_bind;
allow { httpd_t } private_node_t:tcp_socket node_bind;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2BKLkACgkQrlYvE4MpobPdOQCfYCxU0UtzJ71gv1Sl+VNK7uMc
ghYAoI313GNc2oV2XjxNDIbaTEzJSOSl
=gd6B
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
