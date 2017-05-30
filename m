From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 2/2] selinux-testsuite: Infiniband endport tests
Date: Tue, 30 May 2017 16:31:32 +0000
Message-ID: <VI1PR05MB1678FB6A7483B726A2749BFAC4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1495635523-84017-1-git-send-email-danielj@mellanox.com>
 <1495635523-84017-3-git-send-email-danielj@mellanox.com>
 <1495742895.22368.11.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/25/2017 3:04 PM, Stephen Smalley wrote:
> On Wed, 2017-05-24 at 17:18 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>>
>> +allow test_ibendport_manage_subnet_t bin_t:file entrypoint;
>> +allow test_ibendport_manage_subnet_t bin_t:file execute;
> Just use:
> corecmd_bin_entry_type(test_ibendport_manage_subnet_t)

Done

>
>> +allow test_ibendport_manage_subnet_t
>> infiniband_mgmt_device_t:chr_file { read write open ioctl};
>> +corenet_ib_access_unlabeled_pkeys(test_ibendport_manage_subnet_t)
> This interface needs to be wrapped with an ifdef if this file is not
> excluded when refpolicy lacks the necessary definitions.

Done

>> +
>> +allow test_ibendport_manage_subnet_t
>> test_ibendport_t:infiniband_endport manage_subnet;
> This needs to be conditional on the definition of this class.  You
> could either omit the .te file altogether in the Makefile if not
> defined, as we do for e.g. cap_userns, icmp_socket, etc, or you need to
>  wrap it conditionally as we do for e.g. map permission.

Excluded building the .te file if the class is not defined.

>
>> +	@SUBDIRS="$(SUBDIRS) $(SUBDIRS_NO_MAKE)"
>> PATH=/usr/bin:/bin:/usr/sbin:/sbin ./runtests.pl
> This works, but elsewhere we've always just put a trivial Makefile with
> empty all: and clean: targets in it, e.g. entrypoint/Makefile.  No big
> deal either way.

Switched to a stub makefile.
