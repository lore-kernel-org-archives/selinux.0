Message-ID: <5503226A.2060708@tycho.nsa.gov>
Date: Fri, 13 Mar 2015 13:46:18 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andrew Holway <andrew.holway@native-instruments.de>, selinux@tycho.nsa.gov
Subject: Re: Saltstack and ipa-install on Centos7 failing
References: <55031D59.2040909@native-instruments.de>
In-Reply-To: <55031D59.2040909@native-instruments.de>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/13/2015 01:24 PM, Andrew Holway wrote:
> Hallo,
> 
> Could someone please lend a hand with this issue?
> 
> https://www.redhat.com/archives/freeipa-users/2015-March/msg00345.html
> 
> When I run ipa-server-install from Saltstack it is breaking. I imagine
> this is because the script is being run in an unexpected domain
> (init_t rather than unconfined_t).

How is it launched?  How much control do you have over how it is
launched?  If you can just modify its init script or unit file or
whatever, you could either have it invoke runcon with an explicit
context to run in the desired context or put the launch command in a
script file and label it with an appropriate _exec_t type to transition
automatically into the desired domain.  That said, neither initrc_t nor
unconfined_t are particularly desirable domains; it should really have
its own domain.
