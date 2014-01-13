Message-ID: <52D44765.3090407@tresys.com>
Date: Mon, 13 Jan 2014 15:07:01 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
References: <52CF1A53.9080501@redhat.com> <52D01AA2.6080304@tycho.nsa.gov>
In-Reply-To: <52D01AA2.6080304@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/10/14 11:06, Stephen Smalley wrote:
> On 01/09/2014 04:53 PM, Daniel J Walsh wrote:
>> We would like to change
>>
>> sid file_labels         gen_context(system_u:object_r:unlabeled_t,s0)
>>
>> to something like
>>
>> sid file_labels         gen_context(system_u:object_r:invalid_label_t,s0)
>>
>> Since explaining to someone that a file without a label is file_t, but if it
>> has a label that the kernel does not understand it is labeled as unlabeled_t.
>> A file with a label is unlabeled_t????  While a file without a label is file_t.
>>
>>
>> #
>> # unlabeled_t is the type of unlabeled objects.
>> # Objects that have no known labeling information or that
>> # have labels that are no longer valid are treated as having this type.
>> #
>>
>> #
>> # file_t is the default type of a file that has not yet been
>> # assigned an extended attribute (EA) value (when using a filesystem
>> # that supports EAs).
>> #
>>
>> These two type definitions seem to conflict, with file_t winning at least on
>> systems that support XAttrs.
> 
> BTW, if you want to just solve the problem you originally described, you
> can do that just by changing policy to assign unlabeled_t to the file
> initial SID, and then you'll get unlabeled_t for both.  That's what we
> do in the Android policy.

I'm not opposed to doing this in refpolicy.  The concept of what file_t means is tough to explain w/o talking about the mechanics.  It shouldn't be a major change, since normally no one should be doing anything with file_t files other than to fix their label (i.e. same thing as for unlabeled_t files).

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
