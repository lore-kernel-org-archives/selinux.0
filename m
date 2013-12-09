Message-ID: <52A5CF0D.5030405@tycho.nsa.gov>
Date: Mon, 09 Dec 2013 09:09:17 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: MLS required even when MLS is disabled?
References: <20131125201239.GA24780@siphos.be> <5293B163.9080307@tycho.nsa.gov> <5294F1C4.6070403@tycho.nsa.gov> <20131208132231.GA5014@siphos.be>
In-Reply-To: <20131208132231.GA5014@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/08/2013 08:22 AM, Sven Vermeulen wrote:
> On Tue, Nov 26, 2013 at 02:08:52PM -0500, Stephen Smalley wrote:
>> Reverted.  Pushed as policycoreutils-2.2.4.
>> Will accept a new patch on next that does it conditionally under the mls
>> enabled case.
> 
> Another issue related to this one is that, when semanage is called, it sets
> the MLS level (s0) and range (s0) as default. This still triggers the MLS
> warning.
> 
> """
> def parser_add_level(parser, name):
>     parser.add_argument('-L', '--level', default='s0', help=_('Default
>     SELinux Level for SELinux user, s0 Default. (MLS/MCS Systems only)'))
> def parser_add_range(parser, name):
>     parser.add_argument('-r', '--range', default="s0",
>       help=_('''
> """
> 
> With policycoreutils-2.2.4:
> 
> """
> # semanage port -a -t ssh_port_t -p tcp 2222
> libsepol.context_from_record: MLS is disabled, but MLS context "s0" found
> libsepol.context_from_record: could not create context structure (Invalid argument).
> libsepol.port_from_record: could not create port structure for range 2222:2222 (tcp) (Invalid argument).
> libsepol.sepol_port_modify: could not load port range 2222 - 2222 (tcp) (Invalid argument).
> libsemanage.dbase_policydb_modify: could not modify record value (Invalid argument).
> libsemanage.semanage_base_merge_components: could not merge local modifications into policy (Invalid argument).
> OSError: Invalid argument
> """
> 
> If I explicitly mark the range as empty, it works:
> 
> """
> # semanage port -a -t ssh_port_t -p tcp 2222 -r ""
> # echo $?
> 0
> """

Since you seem to have non-MLS policies readily available for testing,
can you try a simple fix to take all of this initialization
under a conditional based on whether MLS is enabled?  Unfortunately this
is otherwise difficult to test on Fedora as they always enable MLS
either for MCS or MLS.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
