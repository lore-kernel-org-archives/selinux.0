Message-ID: <45AE3DCD.8080501@mentalrootkit.com>
Date: Wed, 17 Jan 2007 10:16:29 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Add list and iter data types to libsepol
References: <45AD3F51.9070005@mentalrootkit.com> <1169036139.22731.159.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1169036139.22731.159.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-01-16 at 16:10 -0500, Karl MacMillan wrote:
>> As part of some work to improve the parser in checkpolicy and module 
>> data structures in libsepol, I have implemented doubly-linked list and 
>> iterator data types. The attached patch adds these to libsepol.
>>
>> I would appreciate feedback on these before I submit larger patches that 
>> make use of them. In particular:
>>
>> * Is the iterator concept acceptable (I plan to add iterator support to 
>> other data types including hashtabs)?
> 
> How does this compare with Kevin Carr's previous iterator proposal?

Different implementations and - as far as I remember - different design. 
Same basic idea, though.

>  How
> does it compare with the existing _iterate functions in libsepol?
> 

The iterate functions (which are basically the same as the hashtab 
callbacks) have the same basic goal of allowing external callers to 
iterate over the elements of a data structure without exposing the 
implementation of the data structure. To me, the _iterate functions and 
callbacks have a few problems solved by the iterators:

* Defining callbacks is cumbersome and ofter requires defining data 
structures for passing complex state (see link.c).

* Iterating through nested data structures using callbacks is even more 
painful (see semodule_deps.c for an example of where callbacks would 
have been almost unusable).

* Iterating through multiple, related data structures with the callbacks 
is also difficult or impossible. Think of what the equivalent callbacks 
for the example below would be like (simplified):

int reta, retb;
struct sepol_iter *itera, *iterb;
struct sepol_list *a, *b;

reta = sepol_list_begin(a, itera);
retb = sepol_list_begin(b, iterb);

while (reta == SEPOL_OK && retb == SEPOL_OK) {
	// do something with the data
	sepol_iter_next(itera);
	sepol_iter_next(iterb);
}

* Controlling the traversal (e.g., only visiting every other element or 
stopping traversal) is cumbersome.

* Inserting or removing elements into data structures via callbacks is 
also problematic. At best the performance will be worse. The iterators I 
am proposing can hold whatever state is needed for fast insertion / 
deletion while with the callbacks it is hard to connect the callback 
driver function state (e.g., hashtab_map) with the insertion / deletion 
functions. The hashtab_map_remove_on_error function does work around 
this, but mixing insertion and deletions would be very difficult. See 
test-list.c for an example of how the iterators help with this.

The summary, I think, is that these are a better model overall which is 
why it is a popular approach (at least in non-C languages). Granted, the 
situation is that the callbacks are working for our current needs. So 
I'm not asking for this to be merged without code actually using it 
(which is coming) - just if there are any fundamental objections.

>> * We've discussed dropping the use of typedefs on structs (which I do in 
>> this patch). Is this what we want to do, or should I add typedefs?
> 
> Omitting typedefs is preferred I think.
> 

Ok.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
