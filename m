Message-ID: <52D01C6E.7050201@tycho.nsa.gov>
Date: Fri, 10 Jan 2014 11:14:38 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
References: <52CF1A53.9080501@redhat.com> <52D01AA2.6080304@tycho.nsa.gov>
 <52D01C1B.8040909@redhat.com>
In-Reply-To: <52D01C1B.8040909@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/10/2014 11:13 AM, Daniel J Walsh wrote:
> On 01/10/2014 11:06 AM, Stephen Smalley wrote:
>> On 01/09/2014 04:53 PM, Daniel J Walsh wrote:
>>> We would like to change
>>>
>>> sid file_labels         gen_context(system_u:object_r:unlabeled_t,s0)
>>>
>>> to something like
>>>
>>> sid file_labels
>>> gen_context(system_u:object_r:invalid_label_t,s0)
>>>
>>> Since explaining to someone that a file without a label is file_t, but if
>>> it has a label that the kernel does not understand it is labeled as
>>> unlabeled_t. A file with a label is unlabeled_t????  While a file without
>>> a label is file_t.
>>>
>>>
>>> # # unlabeled_t is the type of unlabeled objects. # Objects that have no
>>> known labeling information or that # have labels that are no longer valid
>>> are treated as having this type. #
>>>
>>> # # file_t is the default type of a file that has not yet been # assigned
>>> an extended attribute (EA) value (when using a filesystem # that supports
>>> EAs). #
>>>
>>> These two type definitions seem to conflict, with file_t winning at least
>>> on systems that support XAttrs.
> 
>> BTW, if you want to just solve the problem you originally described, you 
>> can do that just by changing policy to assign unlabeled_t to the file 
>> initial SID, and then you'll get unlabeled_t for both.  That's what we do
>> in the Android policy.
> 
> 
> Yes I am thinking about that but then we still have the unlabeled_t when the
> object is actually labeled.

Being labeled with a label unknown to the policy is effectively
equivalent to being unlabeled.

> 
> Changing file_t to unlabeled_t, then we have to change some interfaces that
> deal with file_t to deal with unlabeled_t.
> 
> and add an alias for file_t.
