Subject: Re: Collecting ideas for audit2allow improvement
To: Jan Zarsky <jzarsky@redhat.com>, selinux@tycho.nsa.gov
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <c8dedce5-ab89-ced9-d59b-92c5caee3ec5@tycho.nsa.gov>
Date: Wed, 14 Jun 2017 09:58:43 -0400
MIME-Version: 1.0
In-Reply-To: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/14/2017 09:01 AM, Jan Zarsky wrote:
> Hi,
> 
> I would like to improve SELinux audit2allow tool as my bachelor thesis.
> I collected ideas from my colleagues from RedHat SELinux team and I would also
> like to hear your ideas - what would you improve to make audit2allow smarter or
> easier to use.
> 
> Ideas collected so far:
> 
>    * offer dac_read_search when sufficient instead of dac_override
>      (see <https://github.com/SELinuxProject/selinux/issues/31>)
>    * offer multiple solutions to a problem (example: 1) add allow rule for
>      execute + execute_no_trans or 2) add allow rule for execute
>      + type_transition rule)
>    * interactive mode: ask questions and choose best solution
>    * warn when solution touches trusted computing base (rules you should not be
>      adding)
>    * suggest alternate labels for content, example: httpd_t not allowed to write
>      to user_home_t, might suggest that changing the label to
>      httpd_user_content_t
>    * output to CIL (add option for this)

This would definitely be helpful and should be relatively straightforward.

Jim

>    * if the AVC talks about execute permission then offer also type_transition
>      rule
>    * idea for a tool for automatic policy generation: On a test system you
>      install application, turn the SELinux to permissive and run a full test
>      suit. You collect all the AVCs in say Elasticsearch (can use common logging
>      ViaQ project for that) and then there is a tool that searches the AVC,
>      groups them and creates a policy out of them.
>    * add option to open bugzilla
>    * output to Ansible playbook/role task (add option for this)
> 
> I would also like to know which feature would you appreciate the most.
> 
> Thanks
> 
> Jan Zarsky
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
